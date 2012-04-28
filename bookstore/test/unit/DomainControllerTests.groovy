import bookstore.Address
import grails.buildtestdata.mixin.Build
import grails.test.mixin.TestFor
import org.grails.plugins.domainexplorer.DomainController
import org.junit.Test
import grails.converters.JSON

@TestFor(DomainController)
@Build([Address])
class DomainControllerTests {

    @Test
    void rest_Delete() {
        Address address = Address.build()

        request.method = 'DELETE'
        params.id = address.id.toString()
        params.className = Address.class.name

        controller.rest()

        assert !Address.get(address.id)
        assert response.status == 200

        def jsonResponse = JSON.parse(response.text)
        assert jsonResponse.success
    }

    @Test
    void rest_Delete_objectNotFound() {
        request.method = 'DELETE'
        params.id = '1000'
        params.className = Address.class.name

        controller.rest()

        assert response.status == 404

        def jsonResponse = JSON.parse(response.text)
        assert !jsonResponse.success
    }
}
