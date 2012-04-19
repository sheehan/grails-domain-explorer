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

    def listEntities = {
        GrailsDomainClass domainClass = grailsApplication.getDomainClass(params.fullName)
        def json = domainClass.clazz.list(max: 50).collect { domainInstanceToMap it, domainClass }
        render json as JSON
    }

    def domainType = {
        GrailsDomainClass domainClass = grailsApplication.getDomainClass(params.fullName)
        Map json = domainClassToMap(domainClass)
        render json as JSON
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

        while (tokens) {
            String next = tokens.pop()
            Boolean isLast = tokens.empty
            if (next.isLong()) {
                lastId = next as Long
                if (isLast) {
                    result = domainClass.clazz.get(next)
                }
            } else {
                property = domainClass.properties.find { it.name == next }
                if (isLast) {
                    def obj = domainClass.clazz.get(lastId)
                    // TODO if collection, need to add max, pagination params
                    result = obj[next]
                }
                domainClass = property.referencedDomainClass
            }
        }

        Boolean isCollection = result instanceof Collection
        Map json = [
            clazz: domainClassToMap(domainClass),
            isCollection: isCollection,
            value: isCollection ? result.collect { domainInstanceToMap it, domainClass } : domainInstanceToMap(result, domainClass)
        ]
        render json as JSON
    }

    private Map domainClassToMap(GrailsDomainClass domainClass) {
        Map constrainedProperties = domainClass.constrainedProperties

        List properties = domainClass.properties.findAll { it.persistent }.collect { GrailsDomainClassProperty property ->
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
                embedded: property.embedded,
//                    derived: property.derived,
            ]
            ConstrainedProperty cp = constrainedProperties[property.name]
            if (cp) {
//                    m.constraints = cp.properties
            }
            m
        }.sort { it.name == 'id' ? '' : it.name }

        [
            name: domainClass.name,
            fullName: domainClass.fullName,
            count: domainClass.clazz.count(),
            properties: properties
        ]
    }

    private Map domainInstanceToMap(entity, GrailsDomainClass domainClass) {
        Map result = [:]
        domainClass.properties.findAll { it.persistent }.each { GrailsDomainClassProperty property ->
            if (property.oneToMany) {
                result[property.name] = entity[property.name]?.size() ?: 0
            } else {
                result[property.name] = entity[property.name]?.toString()
            }
        }
        result
    }
}
