'use strict';

(function() {
  var APP_NAME = window.__APP_NAME;
  var BASE_URL = window.__BASE_URL;
  var BASE_ELEMENT = window.__BASE_ELEMENT;
  var APP_CONTROLLER_NAME = window.__APP_CONTROLLER_NAME;

  // RequireJS settings
  require.config({
    baseUrl: BASE_URL
  });

  // Prepare controller declaration
  BASE_ELEMENT.setAttribute('ng-controller', APP_CONTROLLER_NAME);

  // Load the app
  function loadApp() {
    // Load configuration
    require(['config'], function() {
      // Load the app itself
      require(['app'], function() {
        // Bootstrap it
        angular.bootstrap(BASE_ELEMENT, [APP_NAME]);
      });
    });
  }

  // Load the libraries and templates
  require(['vendor'], function() {
    require(['angular'], function(angular) {
      // Angular needs to be global
      window.angular = angular;

      // Load the templates and load the app afterwards regardless of whether
      // templates exist
      require(['templates'], loadApp, loadApp);
    });
  });
})();
