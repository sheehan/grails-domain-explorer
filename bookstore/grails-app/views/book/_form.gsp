<%@ page import="bookstore.Book" %>



<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'author', 'error')} required">
	<label for="author">
		<g:message code="book.author.label" default="Author" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="author" name="author.id" from="${bookstore.Author.list()}" optionKey="id" required="" value="${bookInstance?.author?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'invoices', 'error')} ">
	<label for="invoices">
		<g:message code="book.invoices.label" default="Invoices" />
		
	</label>
	<g:select name="invoices" from="${bookstore.Invoice.list()}" multiple="multiple" optionKey="id" size="5" value="${bookInstance?.invoices*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'isbn', 'error')} ">
	<label for="isbn">
		<g:message code="book.isbn.label" default="Isbn" />
		
	</label>
	<g:textField name="isbn" value="${bookInstance?.isbn}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'published', 'error')} required">
	<label for="published">
		<g:message code="book.published.label" default="Published" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="published" precision="day"  value="${bookInstance?.published}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'title', 'error')} ">
	<label for="title">
		<g:message code="book.title.label" default="Title" />
		
	</label>
	<g:textField name="title" value="${bookInstance?.title}"/>
</div>

