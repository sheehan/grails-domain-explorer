
<%@ page import="bookstore.Address" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'address.label', default: 'Address')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-address" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-address" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list address">
			
				<g:if test="${addressInstance?.address1}">
				<li class="fieldcontain">
					<span id="address1-label" class="property-label"><g:message code="address.address1.label" default="Address1" /></span>
					
						<span class="property-value" aria-labelledby="address1-label"><g:fieldValue bean="${addressInstance}" field="address1"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${addressInstance?.address2}">
				<li class="fieldcontain">
					<span id="address2-label" class="property-label"><g:message code="address.address2.label" default="Address2" /></span>
					
						<span class="property-value" aria-labelledby="address2-label"><g:fieldValue bean="${addressInstance}" field="address2"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${addressInstance?.city}">
				<li class="fieldcontain">
					<span id="city-label" class="property-label"><g:message code="address.city.label" default="City" /></span>
					
						<span class="property-value" aria-labelledby="city-label"><g:fieldValue bean="${addressInstance}" field="city"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${addressInstance?.state}">
				<li class="fieldcontain">
					<span id="state-label" class="property-label"><g:message code="address.state.label" default="State" /></span>
					
						<span class="property-value" aria-labelledby="state-label"><g:fieldValue bean="${addressInstance}" field="state"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${addressInstance?.zip}">
				<li class="fieldcontain">
					<span id="zip-label" class="property-label"><g:message code="address.zip.label" default="Zip" /></span>
					
						<span class="property-value" aria-labelledby="zip-label"><g:fieldValue bean="${addressInstance}" field="zip"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${addressInstance?.emailAddress}">
				<li class="fieldcontain">
					<span id="emailAddress-label" class="property-label"><g:message code="address.emailAddress.label" default="Email Address" /></span>
					
						<span class="property-value" aria-labelledby="emailAddress-label"><g:fieldValue bean="${addressInstance}" field="emailAddress"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${addressInstance?.webSite}">
				<li class="fieldcontain">
					<span id="webSite-label" class="property-label"><g:message code="address.webSite.label" default="Web Site" /></span>
					
						<span class="property-value" aria-labelledby="webSite-label"><g:fieldValue bean="${addressInstance}" field="webSite"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${addressInstance?.alternateLatLon}">
				<li class="fieldcontain">
					<span id="alternateLatLon-label" class="property-label"><g:message code="address.alternateLatLon.label" default="Alternate Lat Lon" /></span>
					
						<span class="property-value" aria-labelledby="alternateLatLon-label"><g:fieldValue bean="${addressInstance}" field="alternateLatLon"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${addressInstance?.latLon}">
				<li class="fieldcontain">
					<span id="latLon-label" class="property-label"><g:message code="address.latLon.label" default="Lat Lon" /></span>
					
						<span class="property-value" aria-labelledby="latLon-label"><g:fieldValue bean="${addressInstance}" field="latLon"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${addressInstance?.id}" />
					<g:link class="edit" action="edit" id="${addressInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
