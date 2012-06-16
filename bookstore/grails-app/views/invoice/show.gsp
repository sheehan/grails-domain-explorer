
<%@ page import="bookstore.Invoice" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'invoice.label', default: 'Invoice')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-invoice" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-invoice" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list invoice">
			
				<g:if test="${invoiceInstance?.cardNumber}">
				<li class="fieldcontain">
					<span id="cardNumber-label" class="property-label"><g:message code="invoice.cardNumber.label" default="Card Number" /></span>
					
						<span class="property-value" aria-labelledby="cardNumber-label"><g:fieldValue bean="${invoiceInstance}" field="cardNumber"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${invoiceInstance?.books}">
				<li class="fieldcontain">
					<span id="books-label" class="property-label"><g:message code="invoice.books.label" default="Books" /></span>
					
						<g:each in="${invoiceInstance.books}" var="b">
						<span class="property-value" aria-labelledby="books-label"><g:link controller="book" action="show" id="${b.id}">${b?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${invoiceInstance?.paid}">
				<li class="fieldcontain">
					<span id="paid-label" class="property-label"><g:message code="invoice.paid.label" default="Paid" /></span>
					
						<span class="property-value" aria-labelledby="paid-label"><g:formatBoolean boolean="${invoiceInstance?.paid}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${invoiceInstance?.id}" />
					<g:link class="edit" action="edit" id="${invoiceInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
