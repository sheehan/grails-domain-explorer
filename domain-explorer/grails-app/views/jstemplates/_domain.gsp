<script id="domain-template" type="text/template">
  <div class="header"></div>
  <div class="hql"></div>
  <div class="toolbar"></div>
  <div class="content"></div>
</script>

<script id="domain-list-toolbar" type="text/template">
  <button class="btn create">
    <i class="icon-plus"></i>
    Create
  </button>
  <div class="btn-group page-controls">
    <button class="btn">
      <i class="icon-chevron-left"></i>
    </button>
    <button class="btn">
      <i class="icon-chevron-right"></i>
    </button>
  </div>
</script>

<script id="domain-list-item-view-template" type="text/template">
  {{#each this}}
  <td>{{property_value_cell}}</td>
  {{/each}}
</script>

<script id="confirm-delete-template" type="text/template">
  <div class="modal">
    <div class="modal-header">
      <a class="close" data-dismiss="modal">×</a>
      <h3>Confirm Delete</h3>
    </div>

    <div class="modal-body">
      <p>Are you sure that you want to delete this item?</p>
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

<script id="empty-template" type="text/template">
  <div class="instruction">No domain selected</div>
</script>

<script id="domain-hql-section" type="text/template">
  <textarea>from Address address order by id</textarea>
  <div class="controls">
    <label>max</label>
    <input type="text" name="max" value="50" />
    <label>offset</label>
    <input type="text" name="offset" value="0" />
  </div>
</script>