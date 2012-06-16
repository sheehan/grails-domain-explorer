<%@ page import="bookstore.Invoice" %>



<div class="fieldcontain ${hasErrors(bean: invoiceInstance, field: 'cardNumber', 'error')} ">
	<label for="cardNumber">
		<g:message code="invoice.cardNumber.label" default="Card Number" />
		
	</label>
	<g:textField name="cardNumber" value="${invoiceInstance?.cardNumber}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: invoiceInstance, field: 'books', 'error')} required">
	<label for="books">
		<g:message code="invoice.books.label" default="Books" />
		<span class="required-indicator">*</span>
	</label>
	
</div>

<div class="fieldcontain ${hasErrors(bean: invoiceInstance, field: 'paid', 'error')} ">
	<label for="paid">
		<g:message code="invoice.paid.label" default="Paid" />
		
	</label>
	<g:checkBox name="paid" value="${invoiceInstance?.paid}" />
</div>

