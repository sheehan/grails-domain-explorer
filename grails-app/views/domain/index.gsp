<!DOCTYPE html>
<html lang="en">
<head>
  <title>Test</title>

  <link href="${resource(dir: 'bootstrap/css', file: 'bootstrap.css')}" rel="stylesheet">
  <link href="${resource(dir: 'bootstrap/css', file: 'bootstrap-responsive.css')}" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'layout-default-latest.css')}"/>
  <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'app.css')}"/>
</head>

<body>
<script id="layout-template" type="text/template">
  %{--<div class="navbar navbar-fixed-top">--}%
  %{--<div class="navbar-inner">--}%
  %{--<div class="container">--}%
  %{--<a class="brand" href="#">Project name</a>--}%
  %{--</div>--}%
  %{--</div>--}%
  %{--</div>--}%
  %{--<div class="layout">--}%
  <section id="list"></section>
  <section id="main">&nbsp;</section>
  %{--</div>--}%
</script>
<script id="domain-count-item-template" type="text/template">
  <a href="#"><span class="name">{{name}}</span><span class="count">{{count}}</span></a>
</script>
<script id="domain-template" type="text/template">
  <div>
    <span class="name">{{name}}</span>
    <span class="count">{{count}}</span>
  </div>

  <div>
    <div class="btn-group" data-toggle="buttons-radio">
      <button class="btn">Overview</button>
      <button class="btn">List</button>
      <button class="btn">Create</button>
    </div>
  </div>
</script>
<script id="domain-list-item-template" type="text/template">
  {{id}}
</script>


<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/jquery-1.7.1.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/jquery.layout-latest.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/underscore-min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/backbone-min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vendor/backbone.marionette.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'bootstrap/js', file: 'bootstrap.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'domainexplorer.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'domainexplorer.domainlist.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'domainexplorer.domain.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'domainexplorer.layout.js')}"></script>
</body>
</html>
