<script id="domain-instance-toolbar" type="text/template">
  <div class="btn-group">
    <button class="btn edit">
      <i class="icon-pencil"></i>
      Edit
    </button>
    <button class="btn delete">
      <i class="icon-trash"></i>
      Delete
    </button>
  </div>
</script>

<script id="domain-edit-instance-toolbar" type="text/template">
  <div class="btn-group">
    <button class="btn save">
      <i class="icon-ok"></i>
      Save
    </button>
    <button class="btn cancel">
      <i class="icon-remove"></i>
      Cancel
    </button>
  </div>
</script>

<script id="domain-instance-view-template" type="text/template">
  <div class="form-horizontal">
  {{#each this}}
  <div class="control-group"><label class="control-label">{{property.name}}:</label><div class="controls">{{property_value}}</div></div>
  {{/each}}
  </div>
</script>

<script id="domain-instance-edit-template" type="text/template">
  <div class="errors"></div>
  <form class="form-horizontal">
    {{#each this}}
      <div class="control-group"><label class="control-label">{{property.name}}:</label><div class="controls">{{property_edit}}</div></div>
    {{/each}}
  </form>
  <div class="message-overlay"><div class="message">Saving...</div></div>
</script>