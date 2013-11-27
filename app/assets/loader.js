'use strict';

(function() {
  var APP_NAME = 'myApplication';
  var BASE_URL = '/';

  // RequireJS settings
  require.config({
    baseUrl: BASE_URL
  });

  // Prepare controller declaration
  document.body.setAttribute('ng-controller', 'ApplicationController');

  require(['require', 'vendor'], function(require, vendor) {
    require(['require', 'templates'], function(require, templates) {
      require(['require', 'app'], function(require, app) {
        angular.bootstrap(document.body, [APP_NAME]);
      });
    });
  });
})();
