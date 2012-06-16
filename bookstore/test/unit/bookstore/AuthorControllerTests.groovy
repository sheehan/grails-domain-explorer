package bookstore



import org.junit.*
import grails.test.mixin.*

@TestFor(AuthorController)
@Mock(Author)
class AuthorControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/author/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.authorInstanceList.size() == 0
        assert model.authorInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.authorInstance != null
    }

    void testSave() {
        controller.save()

        assert model.authorInstance != null
        assert view == '/author/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/author/show/1'
        assert controller.flash.message != null
        assert Author.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/author/list'


        populateValidParams(params)
        def author = new Author(params)

        assert author.save() != null

        params.id = author.id

        def model = controller.show()

        assert model.authorInstance == author
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/author/list'


        populateValidParams(params)
        def author = new Author(params)

        assert author.save() != null

        params.id = author.id

        def model = controller.edit()

        assert model.authorInstance == author
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/author/list'

        response.reset()


        populateValidParams(params)
        def author = new Author(params)

        assert author.save() != null

        // test invalid parameters in update
        params.id = author.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/author/edit"
        assert model.authorInstance != null

        author.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/author/show/$author.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        author.clearErrors()

        populateValidParams(params)
        params.id = author.id
        params.version = -1
        controller.update()

        assert view == "/author/edit"
        assert model.authorInstance != null
        assert model.authorInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/author/list'

        response.reset()

        populateValidParams(params)
        def author = new Author(params)

        assert author.save() != null
        assert Author.count() == 1

        params.id = author.id

        controller.delete()

        assert Author.count() == 0
        assert Author.get(author.id) == null
        assert response.redirectedUrl == '/author/list'
    }
}
