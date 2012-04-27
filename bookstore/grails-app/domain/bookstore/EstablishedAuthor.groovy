package bookstore

class EstablishedAuthor {

    static hasMany = [books: Book]

    static constraints = {
        books(nullable: false, minSize: 5)
    }


}
