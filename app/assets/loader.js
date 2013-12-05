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
  baseElement.setAttribute('ng-controller', 'ApplicationController');

  // Load the libraries
  require(['require', 'vendor'], function(require, vendor) {
    // Load the templates
    require(['require', 'templates'], function(require, templates) {
      // Load the app itself
      require(['require', 'app'], function(require, app) {
        // Bootstrap it
        angular.bootstrap(baseElement, [APP_NAME]);
      });
    });
  });
})();
