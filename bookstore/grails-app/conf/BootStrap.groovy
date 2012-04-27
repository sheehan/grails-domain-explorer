import grails.util.Environment
import bookstore.Address

class BootStrap {

    def init = { servletContext ->
        if (Environment.current == Environment.DEVELOPMENT) {
            1000.times {
                Address.build()
            }
        }
    }
    def destroy = {
    }
}
