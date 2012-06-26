(function() {
  var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};
templates['date'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var foundHelper, self=this;


  return "<input name=\"dateOfBirth\" value=\"date.struct\" type=\"hidden\">\n<select name=\"dateOfBirth_day\">\n  <option value=\"1\">1</option>\n  <option value=\"2\">2</option>\n  <option value=\"3\">3</option>\n  <option value=\"4\">4</option>\n  <option value=\"5\">5</option>\n  <option value=\"6\">6</option>\n  <option value=\"7\">7</option>\n  <option value=\"8\">8</option>\n  <option value=\"9\">9</option>\n  <option value=\"10\">10</option>\n  <option value=\"11\">11</option>\n  <option value=\"12\">12</option>\n  <option value=\"13\">13</option>\n  <option value=\"14\">14</option>\n  <option value=\"15\">15</option>\n  <option value=\"16\">16</option>\n  <option value=\"17\">17</option>\n  <option value=\"18\">18</option>\n  <option value=\"19\">19</option>\n  <option value=\"20\">20</option>\n  <option value=\"21\">21</option>\n  <option value=\"22\">22</option>\n  <option value=\"23\">23</option>\n  <option value=\"24\">24</option>\n  <option value=\"25\">25</option>\n  <option value=\"26\">26</option>\n  <option value=\"27\">27</option>\n  <option value=\"28\">28</option>\n  <option value=\"29\">29</option>\n  <option value=\"30\">30</option>\n  <option value=\"31\">31</option>\n</select>\n<select name=\"dateOfBirth_month\">\n  <option value=\"1\">January</option>\n  <option value=\"2\">February</option>\n  <option value=\"3\">March</option>\n  <option value=\"4\">April</option>\n  <option value=\"5\">May</option>\n  <option value=\"6\">June</option>\n  <option value=\"7\">July</option>\n  <option value=\"8\">August</option>\n  <option value=\"9\">September</option>\n  <option value=\"10\">October</option>\n  <option value=\"11\">November</option>\n  <option value=\"12\">December</option>\n</select>\n<select name=\"dateOfBirth_year\">\n<option value=\"1912\">1912</option>\n<option value=\"1913\">1913</option>\n<option value=\"1914\">1914</option>\n<option value=\"1915\">1915</option>\n<option value=\"1916\">1916</option>\n<option value=\"1917\">1917</option>\n<option value=\"1918\">1918</option>\n<option value=\"1919\">1919</option>\n<option value=\"1920\">1920</option>\n<option value=\"1921\">1921</option>\n<option value=\"1922\">1922</option>\n<option value=\"1923\">1923</option>\n<option value=\"1924\">1924</option>\n<option value=\"1925\">1925</option>\n<option value=\"1926\">1926</option>\n<option value=\"1927\">1927</option>\n<option value=\"1928\">1928</option>\n<option value=\"1929\">1929</option>\n<option value=\"1930\">1930</option>\n<option value=\"1931\">1931</option>\n<option value=\"1932\">1932</option>\n<option value=\"1933\">1933</option>\n<option value=\"1934\">1934</option>\n<option value=\"1935\">1935</option>\n<option value=\"1936\">1936</option>\n<option value=\"1937\">1937</option>\n<option value=\"1938\">1938</option>\n<option value=\"1939\">1939</option>\n<option value=\"1940\">1940</option>\n<option value=\"1941\">1941</option>\n<option value=\"1942\">1942</option>\n<option value=\"1943\">1943</option>\n<option value=\"1944\">1944</option>\n<option value=\"1945\">1945</option>\n<option value=\"1946\">1946</option>\n<option value=\"1947\">1947</option>\n<option value=\"1948\">1948</option>\n<option value=\"1949\">1949</option>\n<option value=\"1950\">1950</option>\n<option value=\"1951\">1951</option>\n<option value=\"1952\">1952</option>\n<option value=\"1953\">1953</option>\n<option value=\"1954\">1954</option>\n<option value=\"1955\">1955</option>\n<option value=\"1956\">1956</option>\n<option value=\"1957\">1957</option>\n<option value=\"1958\">1958</option>\n<option value=\"1959\">1959</option>\n<option value=\"1960\">1960</option>\n<option value=\"1961\">1961</option>\n<option value=\"1962\">1962</option>\n<option value=\"1963\">1963</option>\n<option value=\"1964\">1964</option>\n<option value=\"1965\">1965</option>\n<option value=\"1966\">1966</option>\n<option value=\"1967\">1967</option>\n<option value=\"1968\">1968</option>\n<option value=\"1969\">1969</option>\n<option value=\"1970\">1970</option>\n<option value=\"1971\">1971</option>\n<option value=\"1972\">1972</option>\n<option value=\"1973\">1973</option>\n<option value=\"1974\">1974</option>\n<option value=\"1975\">1975</option>\n<option value=\"1976\">1976</option>\n<option value=\"1977\">1977</option>\n<option value=\"1978\">1978</option>\n<option value=\"1979\">1979</option>\n<option value=\"1980\">1980</option>\n<option value=\"1981\">1981</option>\n<option value=\"1982\">1982</option>\n<option value=\"1983\">1983</option>\n<option value=\"1984\">1984</option>\n<option value=\"1985\">1985</option>\n<option value=\"1986\">1986</option>\n<option value=\"1987\">1987</option>\n<option value=\"1988\">1988</option>\n<option value=\"1989\">1989</option>\n<option value=\"1990\">1990</option>\n<option value=\"1991\">1991</option>\n<option value=\"1992\">1992</option>\n<option value=\"1993\">1993</option>\n<option value=\"1994\">1994</option>\n<option value=\"1995\">1995</option>\n<option value=\"1996\">1996</option>\n<option value=\"1997\">1997</option>\n<option value=\"1998\">1998</option>\n<option value=\"1999\">1999</option>\n<option value=\"2000\">2000</option>\n<option value=\"2001\">2001</option>\n<option value=\"2002\">2002</option>\n<option value=\"2003\">2003</option>\n<option value=\"2004\">2004</option>\n<option value=\"2005\">2005</option>\n<option value=\"2006\">2006</option>\n<option value=\"2007\">2007</option>\n<option value=\"2008\">2008</option>\n<option value=\"2009\">2009</option>\n<option value=\"2010\">2010</option>\n<option value=\"2011\">2011</option>\n<option value=\"2012\">2012</option>\n<option value=\"2013\">2013</option>\n<option value=\"2014\">2014</option>\n<option value=\"2015\">2015</option>\n<option value=\"2016\">2016</option>\n<option value=\"2017\">2017</option>\n<option value=\"2018\">2018</option>\n<option value=\"2019\">2019</option>\n<option value=\"2020\">2020</option>\n<option value=\"2021\">2021</option>\n<option value=\"2022\">2022</option>\n<option value=\"2023\">2023</option>\n<option value=\"2024\">2024</option>\n<option value=\"2025\">2025</option>\n<option value=\"2026\">2026</option>\n<option value=\"2027\">2027</option>\n<option value=\"2028\">2028</option>\n<option value=\"2029\">2029</option>\n<option value=\"2030\">2030</option>\n<option value=\"2031\">2031</option>\n<option value=\"2032\">2032</option>\n<option value=\"2033\">2033</option>\n<option value=\"2034\">2034</option>\n<option value=\"2035\">2035</option>\n<option value=\"2036\">2036</option>\n<option value=\"2037\">2037</option>\n<option value=\"2038\">2038</option>\n<option value=\"2039\">2039</option>\n<option value=\"2040\">2040</option>\n<option value=\"2041\">2041</option>\n<option value=\"2042\">2042</option>\n<option value=\"2043\">2043</option>\n<option value=\"2044\">2044</option>\n<option value=\"2045\">2045</option>\n<option value=\"2046\">2046</option>\n<option value=\"2047\">2047</option>\n<option value=\"2048\">2048</option>\n<option value=\"2049\">2049</option>\n<option value=\"2050\">2050</option>\n<option value=\"2051\">2051</option>\n<option value=\"2052\">2052</option>\n<option value=\"2053\">2053</option>\n<option value=\"2054\">2054</option>\n<option value=\"2055\">2055</option>\n<option value=\"2056\">2056</option>\n<option value=\"2057\">2057</option>\n<option value=\"2058\">2058</option>\n<option value=\"2059\">2059</option>\n<option value=\"2060\">2060</option>\n<option value=\"2061\">2061</option>\n<option value=\"2062\">2062</option>\n<option value=\"2063\">2063</option>\n<option value=\"2064\">2064</option>\n<option value=\"2065\">2065</option>\n<option value=\"2066\">2066</option>\n<option value=\"2067\">2067</option>\n<option value=\"2068\">2068</option>\n<option value=\"2069\">2069</option>\n<option value=\"2070\">2070</option>\n<option value=\"2071\">2071</option>\n<option value=\"2072\">2072</option>\n<option value=\"2073\">2073</option>\n<option value=\"2074\">2074</option>\n<option value=\"2075\">2075</option>\n<option value=\"2076\">2076</option>\n<option value=\"2077\">2077</option>\n<option value=\"2078\">2078</option>\n<option value=\"2079\">2079</option>\n<option value=\"2080\">2080</option>\n<option value=\"2081\">2081</option>\n<option value=\"2082\">2082</option>\n<option value=\"2083\">2083</option>\n<option value=\"2084\">2084</option>\n<option value=\"2085\">2085</option>\n<option value=\"2086\">2086</option>\n<option value=\"2087\">2087</option>\n<option value=\"2088\">2088</option>\n<option value=\"2089\">2089</option>\n<option value=\"2090\">2090</option>\n<option value=\"2091\">2091</option>\n<option value=\"2092\">2092</option>\n<option value=\"2093\">2093</option>\n<option value=\"2094\">2094</option>\n<option value=\"2095\">2095</option>\n<option value=\"2096\">2096</option>\n<option value=\"2097\">2097</option>\n<option value=\"2098\">2098</option>\n<option value=\"2099\">2099</option>\n<option value=\"2100\">2100</option>\n<option value=\"2101\">2101</option>\n<option value=\"2102\">2102</option>\n<option value=\"2103\">2103</option>\n<option value=\"2104\">2104</option>\n<option value=\"2105\">2105</option>\n<option value=\"2106\">2106</option>\n<option value=\"2107\">2107</option>\n<option value=\"2108\">2108</option>\n<option value=\"2109\">2109</option>\n<option value=\"2110\">2110</option>\n<option value=\"2111\">2111</option>\n<option value=\"2112\">2112</option>\n</select>\n\n";});

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
  buffer += "\n  <div class=\"control-group ";
  foundHelper = helpers.property;
  stack1 = foundHelper || depth0.property;
  stack1 = (stack1 === null || stack1 === undefined || stack1 === false ? stack1 : stack1.view);
  if(typeof stack1 === functionType) { stack1 = stack1.call(depth0, { hash: {} }); }
  else if(stack1=== undef) { stack1 = helperMissing.call(depth0, "property.view", { hash: {} }); }
  buffer += escapeExpression(stack1) + "\"><label class=\"control-label\">";
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