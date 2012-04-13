package org.grails.plugins.domainexplorer

import org.codehaus.groovy.grails.commons.GrailsDomainClass
import grails.converters.JSON
import org.codehaus.groovy.grails.validation.ConstrainedProperty

class DomainController {

    def index = {

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
//        def js    on = domainClass.clazz.list().collect { entityToMap it, domainClass }
        def json = domainClass.clazz.list(max:50).collect { domainInstanceAsMap it, domainClass }
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
        [
            name: domainClass.name,
            fullName: domainClass.fullName,
            count: domainClass.clazz.count(),
            properties: domainClass.properties.findAll { it.persistent }.collect {
                Map m = [
                    name: it.name,
                    type: it.referencedPropertyType,
                    persistent: it.persistent,
                    optional: it.optional,
                    identity: it.identity,
                    hasOne: it.hasOne,
                    oneToOne: it.oneToOne,
                    oneToMany: it.oneToMany,
                    manyToOne: it.manyToOne,
                    manyToMany: it.manyToMany,
                    bidirectional: it.bidirectional,
                    association: it.association,
                    enum: it.enum,
                    naturalName: it.naturalName,
                    inherited: it.inherited,
                    owningSide: it.owningSide,
                    circular: it.circular,
                    embedded: it.embedded,
//                    derived: it.derived,
                ]
                ConstrainedProperty cp = constrainedProperties[it.name]
                if (cp) {
//                    m.constraints = cp.properties
                }
                m
            }
        ]
    }

    private Map domainInstanceAsMap(entity, GrailsDomainClass domainClass) {
        Map result = [:]
        domainClass.properties.each { property ->
            result[property.name] = entity[property.name]?.toString()
        }
        result
    }
}
