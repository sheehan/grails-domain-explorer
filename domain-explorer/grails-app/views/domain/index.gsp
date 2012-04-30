<%@ page import="grails.converters.JSON" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Domain Explorer</title>

  <link href="${resource(dir: 'bootstrap/css', file: 'bootstrap.css')}" rel="stylesheet">
  <link href="${resource(dir: 'bootstrap/css', file: 'bootstrap-responsive.css')}" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'layout-default-latest.css')}"/>
  <link rel="stylesheet/less" type="text/css" href="${resource(dir: 'css', file: 'app.less')}">
</head>

<body>

<div id="main-content"></div>
<div id="modal"></div>

<script id="layout-template" type="text/template">
  <section id="head-wrapper">
    <div class="navbar">
      <div class="navbar-inner">
        <div class="container">
          <a class="brand" href="#">Domain Explorer</a>
        </div>
      </div>
    </div>
  </section>
  <section id="list-wrapper"></section>
  <section id="main-wrapper">
    <section id="main" class="ui-layout-content">
      <div class="content"></div>
      %{--<div class="footer">&nbsp;</div>--}%
    </section>
  </section>
</script>

<script id="domain-count-item-template" type="text/template">
  <a href="#"><span class="name">{{name}}</span><span class="count">{{count}}</span></a>
</script>

<script id="domain-count-section-template" type="text/template">
  <div class="header">Domains</div>
  <div class="content"><ul></ul></div>
</script>

<script id="domain-template" type="text/template">
  <div class="header"></div>
  <div class="toolbar"></div>
  <div class="content ss"></div>
</script>

<script id="domain-list-toolbar" type="text/template">
  <div class="btn-group page-controls">
    <button class="btn">
      <i class="icon-chevron-left"></i>
    </button>
    <button class="btn">
      <i class="icon-chevron-right"></i>
    </button>
  </div>
</script>

<script id="domain-instance-toolbar" type="text/template">
  <div class="btn-group">
    <button class="btn">
      <i class="icon-pencil"></i>
      Edit
    </button>
    <button class="btn delete">
      <i class="icon-trash"></i>
      Delete
    </button>
  </div>
</script>

<script id="domain-list-item-view-template" type="text/template">
  {{#each this}}
  <td>{{property_value_cell}}</td>
  {{/each}}
</script>

<script id="domain-instance-view-template" type="text/template">
  {{#each this}}
  <div class="control-group"><label class="control-label">{{property.name}}:</label><div class="controls">{{property_value}}</div></div>
  {{/each}}
</script>

<script id="confirm-delete-template" type="text/template">
  <div class="modal">
    <div class="modal-header">
      <a class="close" data-dismiss="modal">×</a>
      <h3>You sure?</h3>
    </div>

    <div class="modal-body">
      <p>You sure about that motherfucker?</p>
    </div>

    <div class="modal-footer">
      <a href="#" class="btn cancel">Cancel</a>
      <a href="#" class="btn btn-primary delete">Delete</a>
    </div>
  </div>
</script>

<script id="delete-success-template" type="text/template">
  <div class="modal">
    <div class="modal-header">
      <a class="close" data-dismiss="modal">×</a>
      <h3>Success</h3>
    </div>

    <div class="modal-body">
      <p>Object deleted.</p>
    </div>

    <div class="modal-footer">
      <a href="#" class="btn btn-primary ok">OK</a>
    </div>
  </div>
</script>

<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/less-1.3.0.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/jquery-1.7.1.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/jquery-ui-1.8.18.custom.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/jquery.layout-latest.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/handlebars-1.0.0.beta.6.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/underscore-min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/backbone-min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/backbone.marionette.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'bootstrap/js', file: 'bootstrap.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'dex.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'dex.domutil.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'dex.modal.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'dex.domainlist.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'dex.domain.js')}"></script>
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
