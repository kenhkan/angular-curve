'use strict';

// What do you mean we don't have a configuration object? Then make one!
window.CURVE_APP = window.CURVE_APP || {
  name: 'Application'
};


// Determine under what environment we are at run-time

// If it's manually set, all is good
if (window.CURVE_APP.environment !== void 0) {

// If it's on localhost, it's obviously development
} else if (window.location.hostname === 'localhost') {
  window.CURVE_APP.environment = 'development'

// If there is the slightest hint it's in staging, let it be
} else if (window.location.hostname.indexOf('staging') > -1) {
  window.CURVE_APP.environment = 'staging'

// Otherwise, it's in production
} else {
  window.CURVE_APP.environment = 'production'
}


// Don't block. Load on next cycle.
window.setTimeout(function() {
  // Make a shortcut to the configuration object
  var curve = window.CURVE_APP;

  // Do not continue if we've already loaded
  if (curve._hasLoaded === true) {
    return;
  }

  // Use globally defined curve.base or assume it from current domain
  curve.base = curve.base || document.URL.match(/https?\:\/\/[^\/]+/)[0];
  // Make sure there's a trailing slash
  if (curve.base[curve.base.length - 1] !== '/') {
    curve.base = curve.base + '/';
  }

  // Default base element to body
  curve.element = curve.element || document.body;

  // Initialize our application
  function init() {
    // If LazyLoad isn't available yet, check again later
    if (window.LazyLoad === void 0) {
      setTimeout(init, 0);
      return;
    }

    // Always have an application controller at root
    curve.element.setAttribute('ng-controller', 'ApplicationController');

    // Load all the styles
    window.LazyLoad.css([
      curve.base + 'vendor.css',
      curve.base + 'app.css'
    ]);

    // Load all the scripts
    window.LazyLoad.js([
      curve.base + 'vendor.js',
      curve.base + 'app.js'
    ], function() {
      // We have loaded
      curve._hasLoaded = true;
      // Bootstrap AngularJS when we're ready
      angular.bootstrap(curve.element, [curve.name]);
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
