
<%@ page import="bookstore.Author" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'author.label', default: 'Author')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-author" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-author" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="firstName" title="${message(code: 'author.firstName.label', default: 'First Name')}" />
					
						<g:sortableColumn property="middleInitial" title="${message(code: 'author.middleInitial.label', default: 'Middle Initial')}" />
					
						<g:sortableColumn property="lastName" title="${message(code: 'author.lastName.label', default: 'Last Name')}" />
					
						<g:sortableColumn property="gender" title="${message(code: 'author.gender.label', default: 'Gender')}" />
					
						<th><g:message code="author.address.label" default="Address" /></th>
					
						<g:sortableColumn property="dateOfBirth" title="${message(code: 'author.dateOfBirth.label', default: 'Date Of Birth')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${authorInstanceList}" status="i" var="authorInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${authorInstance.id}">${fieldValue(bean: authorInstance, field: "firstName")}</g:link></td>
					
						<td>${fieldValue(bean: authorInstance, field: "middleInitial")}</td>
					
						<td>${fieldValue(bean: authorInstance, field: "lastName")}</td>
					
						<td>${fieldValue(bean: authorInstance, field: "gender")}</td>
					
						<td>${fieldValue(bean: authorInstance, field: "address")}</td>
					
						<td><g:formatDate date="${authorInstance.dateOfBirth}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${authorInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
