(function() {
  var dependencies, err, module;

  dependencies = ['titleService'];

  try {
    angular.module('appTemplates');
    dependencies.push('appTemplates');
  } catch (_error) {
    err = _error;
  }

  module = angular.module('myApplication', dependencies);

  module.config(function($locationProvider) {
    return $locationProvider.html5Mode(true);
  });

  module.run(function(titleService) {
    return titleService.setSuffix(" | " + 'myApplication');
  });

}).call(this);
;(function() {
  var module;

  module = angular.module('titleService', []);

  module.factory('titleService', function($document) {
    var suffix, title;
    suffix = title = "";
    return {
      setSuffix: function(s) {
        return suffix = s;
      },
      getSuffix: function() {
        return suffix;
      },
      setTitle: function(t) {
        if (suffix !== "") {
          title = t + suffix;
        } else {
          title = t;
        }
        return $document.prop('title', title);
      },
      getTitle: function() {
        return $document.prop('title');
      }
    };
  });

}).call(this);
;(function() {
  var module;

  module = angular.module('myApplication');

  module.controller('ApplicationController', function($scope, $location) {
    return $scope.message = 'Hello World!';
  });

}).call(this);
;
//# sourceMappingURL=app.js.map