package org.grails.plugins.domainexplorer

import org.codehaus.groovy.grails.commons.GrailsDomainClass
import grails.converters.JSON
import org.codehaus.groovy.grails.validation.ConstrainedProperty
import org.codehaus.groovy.grails.commons.GrailsDomainClassProperty

class DomainController {

    def index = {
        [
            json: [
                baseDir : resource(plugin: 'domain-explorer')
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
        def json = domainClass.clazz.list(max: 50).collect { domainInstanceAsMap it, domainClass }
        render json as JSON
    }

    def domainType = {
        GrailsDomainClass domainClass = grailsApplication.getDomainClass(params.fullName)
        Map json = domainClassToMap(domainClass)
        println json
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

    private Map domainInstanceAsMap(entity, GrailsDomainClass domainClass) {
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
