import bookstore.Address
import bookstore.Author
import grails.util.Environment
import human.Arm

class BootStrap {

    def init = { servletContext ->
        if (Environment.current == Environment.DEVELOPMENT) {
            1000.times {
                Address.build()
                Arm.build()
                Author.build()
            }
        }
    }
    def destroy = {
    }
}
