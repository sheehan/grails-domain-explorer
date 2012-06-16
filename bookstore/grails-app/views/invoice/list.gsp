
<%@ page import="bookstore.Invoice" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'invoice.label', default: 'Invoice')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-invoice" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-invoice" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="cardNumber" title="${message(code: 'invoice.cardNumber.label', default: 'Card Number')}" />
					
						<g:sortableColumn property="paid" title="${message(code: 'invoice.paid.label', default: 'Paid')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${invoiceInstanceList}" status="i" var="invoiceInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${invoiceInstance.id}">${fieldValue(bean: invoiceInstance, field: "cardNumber")}</g:link></td>
					
						<td><g:formatBoolean boolean="${invoiceInstance.paid}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${invoiceInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
