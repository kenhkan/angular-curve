'use strict';

// Don't block. Load on next cycle.
window.setTimeout(function() {
  // Use globally defined BASE_URL or assume it from current URL
  var BASE_URL = window.__BASE_URL || document.URL.match(/https?\:\/\/[^\/]+/)[0];
  // Make sure there's a trailing slash
  if (BASE_URL[BASE_URL.length - 1] !== '/') {
    BASE_URL = BASE_URL + '/';
  }
  // Save a copy for reference
  window.__BASE_URL = BASE_URL;

  // Use LazyLoad
  var lazyLoad = document.createElement('script');
  lazyLoad.type = 'text/javascript';
  lazyLoad.src = '//cdnjs.cloudflare.com/ajax/libs/lazyload/2.0.3/lazyload-min.js';
  document.head.appendChild(lazyLoad);

  // Then load our init script
  var loader = document.createElement('script');
  loader.type = 'text/javascript';
  loader.src = BASE_URL + 'init.js';
  document.head.appendChild(loader);
}, 0);
