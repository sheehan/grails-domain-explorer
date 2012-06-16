<%@ page import="bookstore.Address" %>



<div class="fieldcontain ${hasErrors(bean: addressInstance, field: 'address1', 'error')} ">
	<label for="address1">
		<g:message code="address.address1.label" default="Address1" />
		
	</label>
	<g:textField name="address1" maxlength="55" value="${addressInstance?.address1}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: addressInstance, field: 'address2', 'error')} ">
	<label for="address2">
		<g:message code="address.address2.label" default="Address2" />
		
	</label>
	<g:textField name="address2" maxlength="55" value="${addressInstance?.address2}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: addressInstance, field: 'city', 'error')} ">
	<label for="city">
		<g:message code="address.city.label" default="City" />
		
	</label>
	<g:textField name="city" maxlength="30" value="${addressInstance?.city}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: addressInstance, field: 'state', 'error')} ">
	<label for="state">
		<g:message code="address.state.label" default="State" />
		
	</label>
	<g:textField name="state" maxlength="30" value="${addressInstance?.state}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: addressInstance, field: 'zip', 'error')} ">
	<label for="zip">
		<g:message code="address.zip.label" default="Zip" />
		
	</label>
	<g:textField name="zip" pattern="${addressInstance.constraints.zip.matches}" value="${addressInstance?.zip}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: addressInstance, field: 'emailAddress', 'error')} ">
	<label for="emailAddress">
		<g:message code="address.emailAddress.label" default="Email Address" />
		
	</label>
	<g:field type="email" name="emailAddress" value="${addressInstance?.emailAddress}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: addressInstance, field: 'webSite', 'error')} ">
	<label for="webSite">
		<g:message code="address.webSite.label" default="Web Site" />
		
	</label>
	<g:field type="url" name="webSite" value="${addressInstance?.webSite}"/>
</div>
<fieldset class="embedded"><legend><g:message code="address.alternateLatLon.label" default="Alternate Lat Lon" /></legend>
<div class="fieldcontain ${hasErrors(bean: addressInstance, field: 'alternateLatLon.id', 'error')} required">
	<label for="alternateLatLon.id">
		<g:message code="address.alternateLatLon.id.label" default="Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="id" required="" value="${fieldValue(bean: latLonInstance, field: 'id')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: addressInstance, field: 'alternateLatLon.latitude', 'error')} required">
	<label for="alternateLatLon.latitude">
		<g:message code="address.alternateLatLon.latitude.label" default="Latitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="latitude" step="1E-14" min="-90.0" max="90.0" required="" value="${fieldValue(bean: latLonInstance, field: 'latitude')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: addressInstance, field: 'alternateLatLon.longitude', 'error')} required">
	<label for="alternateLatLon.longitude">
		<g:message code="address.alternateLatLon.longitude.label" default="Longitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="longitude" step="1E-14" min="-180.0" max="180.0" required="" value="${fieldValue(bean: latLonInstance, field: 'longitude')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: addressInstance, field: 'alternateLatLon.version', 'error')} required">
	<label for="alternateLatLon.version">
		<g:message code="address.alternateLatLon.version.label" default="Version" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="version" required="" value="${fieldValue(bean: latLonInstance, field: 'version')}"/>
</div>
</fieldset><fieldset class="embedded"><legend><g:message code="address.latLon.label" default="Lat Lon" /></legend>
<div class="fieldcontain ${hasErrors(bean: addressInstance, field: 'latLon.id', 'error')} required">
	<label for="latLon.id">
		<g:message code="address.latLon.id.label" default="Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="id" required="" value="${fieldValue(bean: latLonInstance, field: 'id')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: addressInstance, field: 'latLon.latitude', 'error')} required">
	<label for="latLon.latitude">
		<g:message code="address.latLon.latitude.label" default="Latitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="latitude" step="1E-14" min="-90.0" max="90.0" required="" value="${fieldValue(bean: latLonInstance, field: 'latitude')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: addressInstance, field: 'latLon.longitude', 'error')} required">
	<label for="latLon.longitude">
		<g:message code="address.latLon.longitude.label" default="Longitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="longitude" step="1E-14" min="-180.0" max="180.0" required="" value="${fieldValue(bean: latLonInstance, field: 'longitude')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: addressInstance, field: 'latLon.version', 'error')} required">
	<label for="latLon.version">
		<g:message code="address.latLon.version.label" default="Version" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="version" required="" value="${fieldValue(bean: latLonInstance, field: 'version')}"/>
</div>
</fieldset>
