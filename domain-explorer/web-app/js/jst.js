(function() {
  var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};
templates['domain/confirmDelete'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var foundHelper, self=this;


  return "<div class=\"modal\">\n  <div class=\"modal-header\">\n    <a class=\"close\" data-dismiss=\"modal\">?</a>\n    <h3>Confirm Delete</h3>\n  </div>\n\n  <div class=\"modal-body\">\n    <p>Are you sure that you want to delete this item?</p>\n  </div>\n\n  <div class=\"modal-footer\">\n    <a href=\"#\" class=\"btn cancel\">Cancel</a>\n    <a href=\"#\" class=\"btn btn-primary delete\">Delete</a>\n  </div>\n</div>";});

templates['domain/deleteSuccess'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var foundHelper, self=this;


  return "<div class=\"modal\">\n  <div class=\"modal-header\">\n    <a class=\"close\" data-dismiss=\"modal\">?</a>\n    <h3>Success</h3>\n  </div>\n\n  <div class=\"modal-body\">\n    <p>Object deleted.</p>\n  </div>\n\n  <div class=\"modal-footer\">\n    <a href=\"#\" class=\"btn btn-primary ok\">OK</a>\n  </div>\n</div>";});

templates['domain/domain'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var foundHelper, self=this;


  return "<div class=\"header\"></div>\n<div class=\"hql\"></div>\n<div class=\"toolbar\"></div>\n<div class=\"content\"></div>";});

templates['domain/empty'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var foundHelper, self=this;


  return "<div class=\"instruction\">No domain selected</div>";});

templates['domain/hqlSection'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var foundHelper, self=this;


  return "<textarea>from Address address order by id</textarea>\n<div class=\"controls\">\n  <label>max</label>\n  <input type=\"text\" name=\"max\" value=\"50\" />\n  <label>offset</label>\n  <input type=\"text\" name=\"offset\" value=\"0\" />\n</div>";});

templates['domain/listItemView'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var stack1, stack2, foundHelper, tmp1, self=this, functionType="function", helperMissing=helpers.helperMissing, undef=void 0, escapeExpression=this.escapeExpression;

function program1(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n<td>";
  foundHelper = helpers.property_value_cell;
  stack1 = foundHelper || depth0.property_value_cell;
  if(typeof stack1 === functionType) { stack1 = stack1.call(depth0, { hash: {} }); }
  else if(stack1=== undef) { stack1 = helperMissing.call(depth0, "property_value_cell", { hash: {} }); }
  buffer += escapeExpression(stack1) + "</td>\n";
  return buffer;}

  stack1 = depth0;
  stack2 = helpers.each;
  tmp1 = self.program(1, program1, data);
  tmp1.hash = {};
  tmp1.fn = tmp1;
  tmp1.inverse = self.noop;
  stack1 = stack2.call(depth0, stack1, tmp1);
  if(stack1 || stack1 === 0) { return stack1; }
  else { return ''; }});

templates['domain/listToolbar'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var foundHelper, self=this;


  return "<button class=\"btn create\">\n  <i class=\"icon-plus\"></i>\n  Create\n</button>\n<div class=\"btn-group page-controls\">\n  <button class=\"btn\">\n    <i class=\"icon-chevron-left\"></i>\n  </button>\n  <button class=\"btn\">\n    <i class=\"icon-chevron-right\"></i>\n  </button>\n</div>";});

templates['domainCount/item'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var buffer = "", stack1, foundHelper, self=this, functionType="function", helperMissing=helpers.helperMissing, undef=void 0, escapeExpression=this.escapeExpression;


  buffer += "<a href=\"#\"><span class=\"name\">";
  foundHelper = helpers.name;
  stack1 = foundHelper || depth0.name;
  if(typeof stack1 === functionType) { stack1 = stack1.call(depth0, { hash: {} }); }
  else if(stack1=== undef) { stack1 = helperMissing.call(depth0, "name", { hash: {} }); }
  buffer += escapeExpression(stack1) + "</span><span class=\"count\">";
  foundHelper = helpers.count;
  stack1 = foundHelper || depth0.count;
  if(typeof stack1 === functionType) { stack1 = stack1.call(depth0, { hash: {} }); }
  else if(stack1=== undef) { stack1 = helperMissing.call(depth0, "count", { hash: {} }); }
  buffer += escapeExpression(stack1) + "</span></a>";
  return buffer;});

templates['domainCount/section'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var foundHelper, self=this;


  return "<div class=\"header\">Domains</div>\n<div class=\"content\"><ul></ul></div>";});

templates['instance/edit'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var buffer = "", stack1, stack2, foundHelper, tmp1, self=this, functionType="function", helperMissing=helpers.helperMissing, undef=void 0, escapeExpression=this.escapeExpression;

function program1(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n  <div class=\"control-group\"><label class=\"control-label\">";
  foundHelper = helpers.property;
  stack1 = foundHelper || depth0.property;
  stack1 = (stack1 === null || stack1 === undefined || stack1 === false ? stack1 : stack1.name);
  if(typeof stack1 === functionType) { stack1 = stack1.call(depth0, { hash: {} }); }
  else if(stack1=== undef) { stack1 = helperMissing.call(depth0, "property.name", { hash: {} }); }
  buffer += escapeExpression(stack1) + ":</label><div class=\"controls\">";
  foundHelper = helpers.property_edit;
  stack1 = foundHelper || depth0.property_edit;
  if(typeof stack1 === functionType) { stack1 = stack1.call(depth0, { hash: {} }); }
  else if(stack1=== undef) { stack1 = helperMissing.call(depth0, "property_edit", { hash: {} }); }
  buffer += escapeExpression(stack1) + "</div></div>\n  ";
  return buffer;}

  buffer += "<div class=\"errors\"></div>\n<form class=\"form-horizontal\">\n  ";
  stack1 = depth0;
  stack2 = helpers.each;
  tmp1 = self.program(1, program1, data);
  tmp1.hash = {};
  tmp1.fn = tmp1;
  tmp1.inverse = self.noop;
  stack1 = stack2.call(depth0, stack1, tmp1);
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n</form>\n<div class=\"message-overlay\"><div class=\"message\">Saving...</div></div>";
  return buffer;});

templates['instance/editToolbar'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var foundHelper, self=this;


  return "<div class=\"btn-group\">\n  <button class=\"btn save\">\n    <i class=\"icon-ok\"></i>\n    Save\n  </button>\n  <button class=\"btn cancel\">\n    <i class=\"icon-remove\"></i>\n    Cancel\n  </button>\n</div>";});

templates['instance/errors'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var buffer = "", stack1, stack2, foundHelper, tmp1, self=this, functionType="function", helperMissing=helpers.helperMissing, undef=void 0, escapeExpression=this.escapeExpression;

function program1(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n  <li>";
  stack1 = depth0;
  if(typeof stack1 === functionType) { stack1 = stack1.call(depth0, { hash: {} }); }
  else if(stack1=== undef) { stack1 = helperMissing.call(depth0, "this", { hash: {} }); }
  buffer += escapeExpression(stack1) + "</li>\n  ";
  return buffer;}

  buffer += "<button class=\"close\" data-dismiss=\"alert\">?</button>\n<ul>\n  ";
  stack1 = depth0;
  stack2 = helpers.each;
  tmp1 = self.program(1, program1, data);
  tmp1.hash = {};
  tmp1.fn = tmp1;
  tmp1.inverse = self.noop;
  stack1 = stack2.call(depth0, stack1, tmp1);
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n</ul>";
  return buffer;});

templates['instance/toolbar'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var foundHelper, self=this;


  return "<div class=\"btn-group\">\n  <button class=\"btn edit\">\n    <i class=\"icon-pencil\"></i>\n    Edit\n  </button>\n  <button class=\"btn delete\">\n    <i class=\"icon-trash\"></i>\n    Delete\n  </button>\n</div>";});

templates['instance/view'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var buffer = "", stack1, stack2, foundHelper, tmp1, self=this, functionType="function", helperMissing=helpers.helperMissing, undef=void 0, escapeExpression=this.escapeExpression;

function program1(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n  <div class=\"control-group\"><label class=\"control-label\">";
  foundHelper = helpers.property;
  stack1 = foundHelper || depth0.property;
  stack1 = (stack1 === null || stack1 === undefined || stack1 === false ? stack1 : stack1.name);
  if(typeof stack1 === functionType) { stack1 = stack1.call(depth0, { hash: {} }); }
  else if(stack1=== undef) { stack1 = helperMissing.call(depth0, "property.name", { hash: {} }); }
  buffer += escapeExpression(stack1) + ":</label><div class=\"controls\">";
  foundHelper = helpers.property_value;
  stack1 = foundHelper || depth0.property_value;
  if(typeof stack1 === functionType) { stack1 = stack1.call(depth0, { hash: {} }); }
  else if(stack1=== undef) { stack1 = helperMissing.call(depth0, "property_value", { hash: {} }); }
  buffer += escapeExpression(stack1) + "</div></div>\n  ";
  return buffer;}

  buffer += "<div class=\"form-horizontal\">\n  ";
  stack1 = depth0;
  stack2 = helpers.each;
  tmp1 = self.program(1, program1, data);
  tmp1.hash = {};
  tmp1.fn = tmp1;
  tmp1.inverse = self.noop;
  stack1 = stack2.call(depth0, stack1, tmp1);
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n</div>";
  return buffer;});

templates['layout'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var foundHelper, self=this;


  return "<section id=\"head-wrapper\">\n  <div class=\"navbar\">\n    <div class=\"navbar-inner\">\n      <div class=\"container\">\n        <a class=\"brand\" href=\"#\">Domain Explorer</a>\n      </div>\n    </div>\n  </div>\n</section>\n<section id=\"list-wrapper\"></section>\n<section id=\"main-wrapper\">\n  <!--<section id=\"main\" class=\"ui-layout-content\">-->\n  <!--<div class=\"content\"></div>-->\n  <!--<div class=\"footer\">&nbsp;</div>-->\n  <!--</section>-->\n</section>\n<section id=\"class-wrapper\">\n\n</section>";});

templates['type/contentToolbarView'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var foundHelper, self=this;


  return "<div class=\"btn-group page-controls\">\n  <button class=\"btn\">\n    <i class=\"icon-chevron-left\"></i>\n  </button>\n  <button class=\"btn\">\n    <i class=\"icon-chevron-right\"></i>\n  </button>\n</div>";});

templates['type/contentView'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var foundHelper, self=this;


  return "<div class=\"toolbar\"></div>\n<div class=\"content\"></div>";});

templates['type/propertyView'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var buffer = "", stack1, foundHelper, self=this, functionType="function", helperMissing=helpers.helperMissing, undef=void 0, escapeExpression=this.escapeExpression;


  buffer += "<td>";
  foundHelper = helpers.name;
  stack1 = foundHelper || depth0.name;
  if(typeof stack1 === functionType) { stack1 = stack1.call(depth0, { hash: {} }); }
  else if(stack1=== undef) { stack1 = helperMissing.call(depth0, "name", { hash: {} }); }
  buffer += escapeExpression(stack1) + "</td><td>";
  foundHelper = helpers.type;
  stack1 = foundHelper || depth0.type;
  if(typeof stack1 === functionType) { stack1 = stack1.call(depth0, { hash: {} }); }
  else if(stack1=== undef) { stack1 = helperMissing.call(depth0, "type", { hash: {} }); }
  buffer += escapeExpression(stack1) + "</td><td>";
  foundHelper = helpers.nullable;
  stack1 = foundHelper || depth0.nullable;
  if(typeof stack1 === functionType) { stack1 = stack1.call(depth0, { hash: {} }); }
  else if(stack1=== undef) { stack1 = helperMissing.call(depth0, "nullable", { hash: {} }); }
  buffer += escapeExpression(stack1) + "</td>";
  return buffer;});

templates['type/queryView'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var foundHelper, self=this;


  return "query";});

templates['type/relationsView'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var foundHelper, self=this;


  return "relations";});

templates['type/toolbarView'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var foundHelper, self=this;


  return "<div class=\"btn-group\" data-toggle=\"buttons-radio\">\n  <button class=\"btn structure\">Structure</button>\n  <button class=\"btn content\">Content</button>\n  <button class=\"btn relations\">Relations</button>\n  <button class=\"btn query\">Query</button>\n</div>";});

templates['type/type'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var foundHelper, self=this;


  return "<div class=\"header\"></div>\n<!--<div class=\"toolbar\"></div>-->\n<div class=\"content\"></div>";});
})();