<script id="domain-type-template" type="text/template">
  <div class="header"></div>
  %{--<div class="toolbar"></div>--}%
  <div class="content"></div>
</script>

<script id="domain-type-toolbar-view-template" type="text/template">
  <div class="btn-group" data-toggle="buttons-radio">
    <button class="btn structure">Structure</button>
    <button class="btn content">Content</button>
    <button class="btn relations">Relations</button>
    <button class="btn query">Query</button>
  </div>
</script>

<script id="domain-type-property-view-template" type="text/template">
  <td>{{name}}</td><td>{{type}}</td><td>{{nullable}}</td>
</script>

<script id="domain-type-content-view-template" type="text/template">
  <div class="toolbar"></div>
  <div class="content"></div>
</script>

<script id="domain-type-content-toolbar-view-template" type="text/template">
  <div class="btn-group page-controls">
    <button class="btn">
      <i class="icon-chevron-left"></i>
    </button>
    <button class="btn">
      <i class="icon-chevron-right"></i>
    </button>
  </div>
</script>

<script id="domain-type-relations-view-template" type="text/template">
  relations
</script>

<script id="domain-type-query-view-template" type="text/template">
  query
</script>