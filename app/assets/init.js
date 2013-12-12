'use strict';

(function() {
  var BASE_URL;

  // Use globally available BASE_URL or assume it
  BASE_URL = window.__BASE_URL || document.URL.match(/https?\:\/\/[^\/]+/)[0] + '/';
  // Save a copy for reference
  window.__BASE_URL = BASE_URL;

  // Inject RequireJS
  var requirejsLoader = document.createElement('script');
  requirejsLoader.type = 'text/javascript';
  requirejsLoader.setAttribute('data-main', BASE_URL + 'loader.js');
  requirejsLoader.src = '//cdnjs.cloudflare.com/ajax/libs/require.js/2.1.9/require.min.js';
  // Do it on next cycle
  setTimeout(function() {
    document.head.appendChild(requirejsLoader);
  }, 0);
})();
