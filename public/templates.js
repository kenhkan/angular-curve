(function() {
  try {
    // Get current templates module
    var module = angular.module('appTemplates');
  } catch (error) {
    // Or create a new one
    var module = angular.module('appTemplates', []);
  }

  module.run(function($templateCache) {
    // Avoid __templateData from tempering with the environment
    var define = void 0, module = void 0;
    // The template getter: assume `__templateData` is a function
    // returning the template content
    var __templateData = function anonymous(locals) {
var buf = [];
buf.push("<h1>{{message}}</h1>");;return buf.join("");
};
if (typeof define === 'function' && define.amd) {
  define("home/index", [], function() {
    return __templateData;
  });
} else if (typeof module === 'object' && module && module.exports) {
  module.exports = __templateData;
} else {
  __templateData;
}
    // Save the template content
    $templateCache.put('app/home/index.jade', __templateData());
  });
})();
;module.exports = function() { return "(function() {\n  try {\n    // Get current templates module\n    var module = angular.module('appTemplates');\n  } catch (error) {\n    // Or create a new one\n    var module = angular.module('appTemplates', []);\n  }\n\n  module.run(function($templateCache) {\n    // Avoid __templateData from tempering with the environment\n    var define = void 0, module = void 0;\n    // The template getter: assume `__templateData` is a function\n    // returning the template content\n    <!-- Placeholder for code generation -->\n\n    // Save the template content\n    $templateCache.put('app/index.html', __templateData());\n  });\n})();";};
;
//# sourceMappingURL=templates.js.map