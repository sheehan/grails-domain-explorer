package bookstore



import org.junit.*
import grails.test.mixin.*

@TestFor(InvoiceController)
@Mock(Invoice)
class InvoiceControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/invoice/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.invoiceInstanceList.size() == 0
        assert model.invoiceInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.invoiceInstance != null
    }

    void testSave() {
        controller.save()

        assert model.invoiceInstance != null
        assert view == '/invoice/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/invoice/show/1'
        assert controller.flash.message != null
        assert Invoice.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/invoice/list'


        populateValidParams(params)
        def invoice = new Invoice(params)

        assert invoice.save() != null

        params.id = invoice.id

        def model = controller.show()

        assert model.invoiceInstance == invoice
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/invoice/list'


        populateValidParams(params)
        def invoice = new Invoice(params)

        assert invoice.save() != null

        params.id = invoice.id

        def model = controller.edit()

        assert model.invoiceInstance == invoice
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/invoice/list'

        response.reset()


        populateValidParams(params)
        def invoice = new Invoice(params)

        assert invoice.save() != null

        // test invalid parameters in update
        params.id = invoice.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/invoice/edit"
        assert model.invoiceInstance != null

        invoice.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/invoice/show/$invoice.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        invoice.clearErrors()

        populateValidParams(params)
        params.id = invoice.id
        params.version = -1
        controller.update()

        assert view == "/invoice/edit"
        assert model.invoiceInstance != null
        assert model.invoiceInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/invoice/list'

        response.reset()

        populateValidParams(params)
        def invoice = new Invoice(params)

        assert invoice.save() != null
        assert Invoice.count() == 1

        params.id = invoice.id

        controller.delete()

        assert Invoice.count() == 0
        assert Invoice.get(invoice.id) == null
        assert response.redirectedUrl == '/invoice/list'
    }
}
