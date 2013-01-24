<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width,initial-scale=1">

  <title>Domain Explorer</title>

  <!-- Application styles. -->

  <!--(if target dummy)><!-->
  <link rel="stylesheet" href="${resource(dir: 'bbb', file: '/dist/debug/vendor/bootstrap/css/bootstrap.css')}">
  <link rel="stylesheet" href="${resource(dir: 'bbb', file: '/dist/debug/app/styles/app.css')}">
  <!--<!(endif)-->

  <!--(if target release)>
  <link rel="stylesheet" href="index.css">
  <!(endif)-->

  <!--(if target debug)>
  <link rel="stylesheet" href="index.css">
  <!(endif)-->
</head>

<body class="container">
<!-- Application container. -->

<main role="main" id="main"></main>

<!-- Application source. -->

<!--(if target dummy)><!-->
<script data-main="${resource(dir: 'bbb', file: '/dist/debug/app/config')}" src="${resource(dir: 'bbb', file: '/vendor/js/libs/require.js')}"></script>
<!--<!(endif)-->

<!--(if target release)>
  <script src="require.js"></script>
  <!(endif)-->

<div>
  <div class="navbar">
    <div class="navbar-inner">
      <a class="brand" href="#">Domain Explorer</a>
    </div>
  </div>
</div>
<div id="main-content"></div>

<!--(if target debug)>
  <script src="require.js"></script>
  <!(endif)-->
</body>
</html>
