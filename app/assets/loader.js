'use strict';

// Don't block. Load on next cycle.
window.setTimeout(function() {
  // Do not continue if we've already loaded
  if (window.__APP_LOADED === true) {
    return;
  }

  // Use globally defined BASE_URL or assume it from current domain
  var BASE_URL = window.__BASE_URL || document.URL.match(/https?\:\/\/[^\/]+/)[0];
  // Make sure there's a trailing slash
  if (BASE_URL[BASE_URL.length - 1] !== '/') {
    BASE_URL = BASE_URL + '/';
  }

  // Default base element to body
  var BASE_ELEMENT = window.__BASE_ELEMENT || document.body;

  // Initialize our application
  function init() {
    // If LazyLoad isn't available yet, check again later
    if (window.LazyLoad === void 0) {
      setTimeout(init, 0);
      return;
    }

    // Always have an application controller at root
    BASE_ELEMENT.setAttribute('ng-controller', 'ApplicationController');

    // Load all the styles
    window.LazyLoad.css([
      BASE_URL + '/vendor.css',
      BASE_URL + '/app.css'
    ]);

    // Load all the scripts
    window.LazyLoad.js([
      BASE_URL + '/vendor.js',
      BASE_URL + '/templates.js',
      BASE_URL + '/app.js'
    ], function() {
      // We have loaded
      window.__APP_LOADED = true;
      // Bootstrap AngularJS when we're ready
      angular.bootstrap(BASE_ELEMENT, [__APP_NAME]);
    });
  }

  // Use LazyLoad
  var lazyLoad = document.createElement('script');
  lazyLoad.type = 'text/javascript';
  lazyLoad.src = '//cdnjs.cloudflare.com/ajax/libs/lazyload/2.0.3/lazyload-min.js';
  document.head.appendChild(lazyLoad);

  // Then load our init script
  setTimeout(init, 0);
}, 0);
