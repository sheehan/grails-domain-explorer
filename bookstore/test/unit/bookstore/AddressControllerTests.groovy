package bookstore



import org.junit.*
import grails.test.mixin.*

@TestFor(AddressController)
@Mock(Address)
class AddressControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/address/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.addressInstanceList.size() == 0
        assert model.addressInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.addressInstance != null
    }

    void testSave() {
        controller.save()

        assert model.addressInstance != null
        assert view == '/address/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/address/show/1'
        assert controller.flash.message != null
        assert Address.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/address/list'


        populateValidParams(params)
        def address = new Address(params)

        assert address.save() != null

        params.id = address.id

        def model = controller.show()

        assert model.addressInstance == address
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/address/list'


        populateValidParams(params)
        def address = new Address(params)

        assert address.save() != null

        params.id = address.id

        def model = controller.edit()

        assert model.addressInstance == address
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/address/list'

        response.reset()


        populateValidParams(params)
        def address = new Address(params)

        assert address.save() != null

        // test invalid parameters in update
        params.id = address.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/address/edit"
        assert model.addressInstance != null

        address.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/address/show/$address.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        address.clearErrors()

        populateValidParams(params)
        params.id = address.id
        params.version = -1
        controller.update()

        assert view == "/address/edit"
        assert model.addressInstance != null
        assert model.addressInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/address/list'

        response.reset()

        populateValidParams(params)
        def address = new Address(params)

        assert address.save() != null
        assert Address.count() == 1

        params.id = address.id

        controller.delete()

        assert Address.count() == 0
        assert Address.get(address.id) == null
        assert response.redirectedUrl == '/address/list'
    }
}
