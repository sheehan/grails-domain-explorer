package bookstore

class Book {
   String title
   String isbn
   Date published
   
   static belongsTo = [author: Author]
   static hasMany = [invoices: Invoice]

}
