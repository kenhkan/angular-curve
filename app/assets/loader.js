'use strict';

(function() {
  // This app's name. Must match what you have in `angular.module()`
  var APP_NAME = 'myApplication';
  // Base URL for RequireJS to load files
  var BASE_URL = '/';
  // Element on which to load AngularJS
  var baseElement = document.body;

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
