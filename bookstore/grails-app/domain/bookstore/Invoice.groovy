package bookstore

class Invoice {
    String cardNumber
    
    static hasMany = [books: Book]
    static belongsTo = [Customer, Book]

    // Minimum order of 3, heh
    static constraints = {
        cardNumber(creditCard:true)
        books(nullable: false, minSize: 3)
    }

}
