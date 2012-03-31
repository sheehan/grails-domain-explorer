package org.grails.plugins.domainexplorer

import org.codehaus.groovy.grails.commons.GrailsDomainClass
import grails.converters.JSON

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
            count: domainClass.clazz.count()
        ]
        render json as JSON
    }
}
