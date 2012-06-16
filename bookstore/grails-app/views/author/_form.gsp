<%@ page import="bookstore.Author" %>



<div class="fieldcontain ${hasErrors(bean: authorInstance, field: 'firstName', 'error')} required">
	<label for="firstName">
		<g:message code="author.firstName.label" default="First Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="firstName" maxlength="25" required="" value="${authorInstance?.firstName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: authorInstance, field: 'middleInitial', 'error')} ">
	<label for="middleInitial">
		<g:message code="author.middleInitial.label" default="Middle Initial" />
		
	</label>
	<g:textField name="middleInitial" maxlength="1" value="${authorInstance?.middleInitial}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: authorInstance, field: 'lastName', 'error')} required">
	<label for="lastName">
		<g:message code="author.lastName.label" default="Last Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="lastName" maxlength="35" required="" value="${authorInstance?.lastName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: authorInstance, field: 'gender', 'error')} required">
	<label for="gender">
		<g:message code="author.gender.label" default="Gender" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="gender" from="${authorInstance.constraints.gender.inList}" required="" value="${authorInstance?.gender}" valueMessagePrefix="author.gender"/>
</div>

<div class="fieldcontain ${hasErrors(bean: authorInstance, field: 'address', 'error')} required">
	<label for="address">
		<g:message code="author.address.label" default="Address" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="address" name="address.id" from="${bookstore.Address.list()}" optionKey="id" required="" value="${authorInstance?.address?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: authorInstance, field: 'books', 'error')} required">
	<label for="books">
		<g:message code="author.books.label" default="Books" />
		<span class="required-indicator">*</span>
	</label>
	
<ul class="one-to-many">
<g:each in="${authorInstance?.books?}" var="b">
    <li><g:link controller="book" action="show" id="${b.id}">${b?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="book" action="create" params="['author.id': authorInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'book.label', default: 'Book')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: authorInstance, field: 'dateOfBirth', 'error')} required">
	<label for="dateOfBirth">
		<g:message code="author.dateOfBirth.label" default="Date Of Birth" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="dateOfBirth" precision="day"  value="${authorInstance?.dateOfBirth}"  />
</div>

