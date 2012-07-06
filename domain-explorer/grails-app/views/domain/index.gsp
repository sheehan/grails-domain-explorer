<%@ page import="grails.converters.JSON" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Domain Explorer</title>

  <link href="${resource(dir: 'bootstrap/css', file: 'bootstrap.css')}" rel="stylesheet">
  <link href="${resource(dir: 'bootstrap/css', file: 'bootstrap-responsive.css')}" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'layout-default-latest.css')}"/>
  <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'app.css')}">
  <link type="image/x-icon" rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" />
</head>

<body>

<div id="main-content"></div>
<div id="modal"></div>

<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/jquery-1.7.1.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/jquery-ui-1.8.18.custom.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/jquery.layout-latest.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/moment.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/handlebars.runtime-1.0.0.beta.6.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/underscore-min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/backbone-min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/backbone.marionette.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/backbone.syphon.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'bootstrap/js', file: 'bootstrap.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jst.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'dex.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'dex.domutil.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'dex.modal.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'dex.domainlist.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'dex.domain.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'dex.domain.type.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'dex.domain.instance.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'dex.layout.js')}"></script>

<script type="text/javascript">
  jQuery(function($) {
    var json = ${(json ?: [:]) as JSON};
    Dex.start(json);
  });
</script>

</body>
</html>
