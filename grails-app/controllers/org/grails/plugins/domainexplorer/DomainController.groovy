package org.grails.plugins.domainexplorer

import org.codehaus.groovy.grails.commons.GrailsDomainClass
import grails.converters.JSON
import org.codehaus.groovy.grails.validation.ConstrainedProperty

class DomainController {

    def index() {

    }

    def list() {
        def json = grailsApplication.domainClasses.collect { GrailsDomainClass clazz ->
            [
                name: clazz.name,
                fullName: clazz.fullName,
                count: clazz.clazz.count()
            ]
        }.sort { it.name }
        render json as JSON
    }

    def item() {
        GrailsDomainClass domainClass = grailsApplication.getDomainClass(params.fullName)
        def json = [
            fullName: domainClass.fullName,
            name: domainClass.name,
            count: domainClass.clazz.count()
        ]
        render json as JSON
    }

    def listEntities() {
        GrailsDomainClass domainClass = grailsApplication.getDomainClass(params.fullName)
//        def json = domainClass.clazz.list().collect { entityToMap it, domainClass }
        def json = domainClass.clazz.list()
        render json as JSON
    }

    def domainType() {
        GrailsDomainClass domainClass = grailsApplication.getDomainClass(params.fullName)
        Map constrainedProperties = domainClass.constrainedProperties
        Map json = [
            name: domainClass.name,
            fullName: domainClass.fullName,
            properties: domainClass.properties.collect {
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
                    derived: it.derived,
                ]
                ConstrainedProperty cp = constrainedProperties[it.name]
                if (cp) {
                    m.constraints = cp.properties
                }
                m
            }
        ]
        render json as JSON
    }

    private Map entityToMap(entity, GrailsDomainClass domainClass) {
        entity as Map // TODO
    }
}
