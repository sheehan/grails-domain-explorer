package org.grails.plugins.domainexplorer

import grails.converters.JSON
import org.codehaus.groovy.grails.commons.GrailsDomainClass
import org.codehaus.groovy.grails.commons.GrailsDomainClassProperty
import org.codehaus.groovy.grails.validation.ConstrainedProperty
import org.springframework.web.servlet.support.RequestContextUtils

class DomainController {

    def index() {
        [
            json: [
                serverURL: grailsApplication.config.grails.serverURL
            ]
        ]
    }

    def list() {
        List json = grailsApplication.domainClasses.collect { GrailsDomainClass clazz ->
            [
                name: clazz.name,
                fullName: clazz.fullName,
                count: clazz.clazz.count()
            ]
        }.sort { it.name }
        render json as JSON
    }

    def executeQuery(String query, int max, int offset) {
        List result = grailsApplication.domainClasses.first().clazz.executeQuery(query, [:], [max: max, offset: offset])
        Map json = [:]
        if (result) {
            GrailsDomainClass domainClass = grailsApplication.getDomainClass(result[0].class.name)
            json.clazz = domainClassToMap(domainClass)
            json.value = result.collect { domainInstanceToMap it, domainClass }
        } else {
            json.value = []
        }
        render json as JSON
    }

    def findPropertyOne(String className, Long id, String property) {
        GrailsDomainClass sourceDomainClass = grailsApplication.getDomainClass(className)
        GrailsDomainClass propertyDomainClass = sourceDomainClass.properties.find { it.name == property }.referencedDomainClass
        Class clazz = sourceDomainClass.clazz
        Object instance = clazz.get(id)
        Object value = instance[property]

        Map json = [:]
        json.clazz = domainClassToMap(propertyDomainClass)
        json.value = domainInstanceToMap value, propertyDomainClass
        render json as JSON
    }

    def rest = {
        switch (request.method) {
            case "POST":
                create()
                break
            case "GET":
                show()
                break
            case "PUT":
                update()
                break
            case "DELETE":
                delete()
                break
        }
    }


    private show() {
        def data = retrieveRecord()
        render text: data.result as JSON, contentType: 'application/json', status: data.status
    }

    private create() {
        def result = [success: true]
        def status = 200
        def entity = grailsApplication.getClassForName(params.className)
        if (entity) {
            def obj = entity.newInstance()
            obj.properties = request.JSON.data
            obj.validate()
            if (obj.hasErrors()) {
                status = 500
                result.message = extractErrors(obj).join(";")
                result.success = false
            } else {
                result.data = obj.save(flush: true)
            }
        } else {
            result.success = false
            result.message = "Entity ${params.className} not found"
            status = 500
        }
        render text: result as JSON, contentType: 'application/json', status: status
    }

    private update() {
        def data = retrieveRecord()
        if (data.result.success) {
            try {
                data.result.data.properties = request.JSON
                data.result.data.validate()
                if (data.result.data.hasErrors()) {
                    data.status = 500
                    data.result.errors = extractErrors(data.result.data)
                    data.result.success = false
                } else {
                    data.result.data = data.result.data.save(flush: true)
                }
            } catch (e) {
                data.status = 500
                data.result.errors = [e.message]
                data.result.success = false
            }
        }
        response.status = data.status

        GrailsDomainClass domainClass = grailsApplication.getDomainClass(params.className)
        data.result.data = domainInstanceToMap(data.result.data, domainClass)
        render data.result as JSON
    }

    private delete() {
        def data = retrieveRecord()
        try {
            if (data.result.success) {
                data.result.data.delete(flush: true)
            }
        } catch (Exception e) {
            data.result.success = false
            data.result.message = e.message
            data.result.status = 500
        }
        render text: data.result as JSON, contentType: 'application/json', status: data.status
    }

    private retrieveRecord() {
        def result = [success: true]
        def status = 200
        def entity = grailsApplication.getClassForName(params.className)
        if (entity) {
            def obj = entity.get(params.id)
            if (obj) {
                result.data = obj
            } else {
                result.success = false
                result.message = "Object with id=${params.id} not found"
                status = 404
            }
        } else {
            result.success = false
            result.message = "Entity ${params.className} not found"
            status = 500
        }

        [result: result, status: status]
    }

    def messageSource

    private extractErrors(model) {
        def locale = RequestContextUtils.getLocale(request)
        model.errors.fieldErrors.collect { error ->
            messageSource.getMessage(error, locale)
        }
    }

    def fromPath = {
        List tokens = params.path.split('/').toList().reverse()

        String fullName = tokens.pop()
        GrailsDomainClass domainClass = grailsApplication.getDomainClass(fullName)

        Object result
        Long lastId
        GrailsDomainClassProperty property

        if (!tokens) {
            result = domainClass.clazz.list(max: 50)
        }

        // TODO clean up this mess!!
        List maps = [[domainClass: domainClass]]

        while (tokens) {
            String next = tokens.pop()
            Boolean isLast = tokens.empty
            if (next.isLong()) {
                lastId = next as Long
                maps[-1].id = lastId
            } else {
                property = domainClass.properties.find { it.name == next }

                domainClass = property.referencedDomainClass
                maps << [domainClass: domainClass, domainProperty: property]
            }
            if (isLast) {
                Integer index = maps.findLastIndexOf { it.id }
                Map map = maps[index]
                result = map.domainClass.clazz.get(map.id)
                if (maps.size() > index + 1) {
                    maps[(index + 1)..-1].each { m ->
                        result = result[m.domainProperty.name]
                    }
                }
            }
        }

        Boolean isCollection = result instanceof Collection
        Map json = [
            clazz: domainClassToMap(domainClass),
            isCollection: isCollection
        ]
        if (isCollection) {
            json.value = result.toList().sort { it.id }.collect { domainInstanceToMap it, domainClass }
        } else {
            json.value = domainInstanceToMap(result, domainClass)
        }
        render json as JSON
    }

    def listInstances = {
        GrailsDomainClass domainClass = grailsApplication.getDomainClass(params.fullName)
        Object result = domainClass.clazz.list(max: 50)

        Map json = [
            clazz: domainClassToMap(domainClass),
            list: result.toList().sort { it.id }.collect { domainInstanceToMap it, domainClass }
        ]
        render json as JSON
    }

    private Map domainClassToMap(GrailsDomainClass domainClass) {
        Map constrainedProperties = domainClass.constrainedProperties

        List properties = getProperties(domainClass).collect { GrailsDomainClassProperty property ->
            Map m = [
                name: property.name,
                type: property.referencedPropertyType,
                view: determinePropertyView(property),
                persistent: property.persistent,
                optional: property.optional,
                identity: property.identity,
                hasOne: property.hasOne,
                oneToOne: property.oneToOne,
                oneToMany: property.oneToMany,
                manyToOne: property.manyToOne,
                manyToMany: property.manyToMany,
                bidirectional: property.bidirectional,
                association: property.association,
                enum: property.enum,
                naturalName: property.naturalName,
                inherited: property.inherited,
                owningSide: property.owningSide,
                circular: property.circular,
                embedded: property.embedded
            ]
            ConstrainedProperty cp = constrainedProperties[property.name]
            if (cp) {
                m.constraints = [
                    format: cp.format,
                    inList: cp.inList?.toString(),
                    matches: cp.propertyType == String.class ? cp.matches : null,
                    max: cp.max?.toString(),
                    maxSize: cp.maxSize?.toString(),
                    min: cp.min?.toString(),
                    minSize: cp.minSize?.toString(),
                    order: cp.order,
                    range: cp.range?.toString(),
                    scale: cp.scale?.toString(),
                    size: cp.size?.toString(),
                    widget: cp.widget,
                    blank: cp.blank,
                    creditCard: cp.propertyType == String.class ? cp.creditCard : null,
                    display: cp.display,
                    editable: cp.editable,
                    email: cp.propertyType == String.class ? cp.email : null,
                    nullable: cp.nullable,
                    url: cp.propertyType == String.class ? cp.url : null
                ]
            }
            if (property.embedded) {
                m.clazz = domainClassToMap(property.component)
            }
            m
        }

        [
            name: domainClass.name,
            fullName: domainClass.fullName,
            count: domainClass.clazz.count(),
            properties: properties
        ]
    }

    private static String determinePropertyView(GrailsDomainClassProperty property) {
        if (property.type == Boolean || property.type == boolean) {
            return 'boolean'
        } else if (property.type && Number.isAssignableFrom(property.type) || (property.type?.isPrimitive() && property.type != boolean)) {
            return 'number'
        } else if (property.type == String) {
            return 'string'
        } else if (property.type == Date || property.type == java.sql.Date || property.type == java.sql.Time || property.type == Calendar) {
            return 'date'
        } else if (property.type == URL) {
            return 'string'
        } else if (property.type && property.isEnum()) {
            return 'enum'
        } else if (property.type == TimeZone) {
            return 'timeZone'
        } else if (property.type == Locale) {
            return 'locale'
        } else if (property.type == Currency) {
            return 'currency'
        } else if ((property.type == ([] as Byte[]).class) || (property.type == ([] as byte[]).class)) { //TODO: Bug in groovy means i have to do this :(
            return 'file'
        } else if (property.embedded) {
            return 'embedded'
        } else if (property.manyToOne || property.oneToOne) {
            return 'associationOne'
        } else if ((property.oneToMany /*&& !property.bidirectional*/) || (property.manyToMany /*&& property.isOwningSide()*/)) {
            return 'associationMany'
        } else if (property.oneToMany) {
            return 'associationMany'
        }
        return 'string'
    }

    private static Map domainInstanceToMap(entity, GrailsDomainClass domainClass) {
        Map result = [
            className: domainClass.fullName
        ]
        getProperties(domainClass).each { GrailsDomainClassProperty property ->
            String propertyView = determinePropertyView(property)
            def value = entity[property.name]
            switch (propertyView) {
                case 'associationMany':
                    result[property.name] = value?.size() ?: 0
                    break
                case 'associationOne':
                    result[property.name] = value?.id
                    break
                case 'date':
                    result[property.name] = value?.format("yyyy-MM-dd'T'HH:mm:ss.SSSZ")
                    break
                case 'embedded':
                    GrailsDomainClass embeddedClass = property.component
                    result[property.name] = value ? domainInstanceToMap(value, embeddedClass) : null
                    break
                default:
                    result[property.name] = value?.toString()
            }
        }
        result
    }

    private static List<GrailsDomainClassProperty> getProperties(GrailsDomainClass domainClass) {
        List props = []
        if (domainClass.identifier) {
            props << domainClass.identifier
        }
        if (domainClass.version) {
            props << domainClass.version
        }
        props.addAll domainClass.persistentProperties.sort { it.name }
        props
    }
}
