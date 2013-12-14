'use strict';

// Initialize our application
(function() {
  function init() {
    // If LazyLoad isn't available yet, check again later
    if (window.LazyLoad === void 0) {
      setTimeout(init, 0);
      return;
    }

    var APP_NAME = window.__APP_NAME;
    var BASE_URL = window.__BASE_URL;
    var BASE_ELEMENT = window.__BASE_ELEMENT;
    var APP_CONTROLLER_NAME = window.__APP_CONTROLLER_NAME;

    // Prepare application controller
    BASE_ELEMENT.setAttribute('ng-controller', APP_CONTROLLER_NAME);

    // Load the libraries, templates, configuration, then the app itself
    window.LazyLoad.js(['vendor.js', 'templates.js', 'config.js', 'app.js'], function() {
      angular.bootstrap(BASE_ELEMENT, [APP_NAME]);

      // We have loaded
      window.__APP_LOADED = true;
    });
  }

  // Start initialization
  setTimeout(init, 0);
})();
