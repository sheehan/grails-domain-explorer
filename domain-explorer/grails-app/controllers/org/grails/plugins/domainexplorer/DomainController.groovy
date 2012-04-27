package org.grails.plugins.domainexplorer

import grails.converters.JSON
import org.codehaus.groovy.grails.commons.GrailsDomainClass
import org.codehaus.groovy.grails.commons.GrailsDomainClassProperty
import org.codehaus.groovy.grails.validation.ConstrainedProperty

class DomainController {

    def index = {
        [
            json: [
                serverURL: grailsApplication.config.grails.serverURL
            ]
        ]
    }

    def list = {
        def json = grailsApplication.domainClasses.collect { GrailsDomainClass clazz ->
            [
                name: clazz.name,
                fullName: clazz.fullName,
                count: clazz.clazz.count()
            ]
        }.sort { it.name }
        render json as JSON
    }

    def rest = {
        switch(request.method){
            case "POST":
                break
            case "GET":
                break
            case "PUT":
                break
            case "DELETE":
//                grailsApplication.
                break
        }
        render 'aaa'
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

    private Map domainClassToMap(GrailsDomainClass domainClass) {
        Map constrainedProperties = domainClass.constrainedProperties

        List properties = getProperties(domainClass).collect { GrailsDomainClassProperty property ->
            Map m = [
                name: property.name,
                type: property.referencedPropertyType,
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
            m
        }

        [
            name: domainClass.name,
            fullName: domainClass.fullName,
            count: domainClass.clazz.count(),
            properties: properties
        ]
    }

    private Map domainInstanceToMap(entity, GrailsDomainClass domainClass) {
        Map result = [
            className: domainClass.fullName
        ]
        getProperties(domainClass).each { GrailsDomainClassProperty property ->
            if (property.oneToMany || property.manyToMany) {
                result[property.name] = entity[property.name]?.size() ?: 0
            } else if (property.association && (property.oneToOne || property.manyToOne)) {
                result[property.name] = entity[property.name]?.id
            } else {
                result[property.name] = entity[property.name]?.toString()
            }
        }
        result
    }

    private getProperties(GrailsDomainClass domainClass) {
        List props = domainClass.persistentProperties
        props << domainClass.identifier
        if (domainClass.version) {
            props << domainClass.version
        }
        props.sort { it.name == 'id' ? '' : it.name }
    }
}
