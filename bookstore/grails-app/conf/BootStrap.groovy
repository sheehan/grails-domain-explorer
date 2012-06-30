import bookstore.Address
import bookstore.Author
import grails.util.Environment
import human.Arm
import bookstore.Invoice
import org.codehaus.groovy.grails.commons.GrailsDomainClass

class BootStrap {

    def grailsApplication

    def init = { servletContext ->
        if (Environment.current == Environment.DEVELOPMENT) {
            grailsApplication.domainClasses.each { GrailsDomainClass domainClass ->
                log.debug "building: $domainClass.clazz"
                5.times { domainClass.clazz.build() }
            }
        }
    }
    def destroy = {
    }
}
