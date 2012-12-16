<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width,initial-scale=1">

  <title>Backbone Boilerplate</title>

  <!-- Application styles. -->

  <!--(if target dummy)><!-->
  <link rel="stylesheet" href="${resource(dir: 'bbb', file: '/app/styles/index.css')}">
  <!--<!(endif)-->

  <!--(if target release)>
  <link rel="stylesheet" href="index.css">
  <!(endif)-->

  <!--(if target debug)>
  <link rel="stylesheet" href="index.css">
  <!(endif)-->
</head>

<body>
<!-- Application container. -->

<main role="main" id="main"></main>

<!-- Application source. -->

<!--(if target dummy)><!-->
<script data-main="${resource(dir: 'bbb', file: '/app/config')}" src="${resource(dir: 'bbb', file: '/vendor/js/libs/require.js')}"></script>
<!--<!(endif)-->

<!--(if target release)>
  <script src="require.js"></script>
  <!(endif)-->

hi

<!--(if target debug)>
  <script src="require.js"></script>
  <!(endif)-->
</body>
</html>
