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
      <div class="footer">&nbsp;</div>
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
  <div class="header">
    <span class="name">{{name}}</span>
    <span class="count">({{count}})</span>
  </div>

  <div class="toolbar">
    <div class="btn-group" data-toggle="buttons-radio">
      <button class="btn overview">Overview</button>
      <button class="btn list">List</button>
    </div>
  </div>

  <div class="content"></div>
</script>
<script id="domain-overview-template" type="text/template">
  overview {{name}}
</script>
<script id="domain-create-template" type="text/template">
  create {{name}}
</script>

<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/less-1.3.0.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/jquery-1.7.1.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/jquery-ui-1.8.18.custom.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/jquery.layout-latest.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/underscore-min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/backbone-min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/backbone.marionette2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'bootstrap/js', file: 'bootstrap.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'domainexplorer.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'domainexplorer.domainlist.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'domainexplorer.domain.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'domainexplorer.layout.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'domainexplorer.jqueryplugins.js')}"></script>
</body>
</html>
