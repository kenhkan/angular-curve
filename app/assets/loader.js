(function() {
  // Your AngularJS application's name
  var APP_NAME = 'myApplication';
  // Your templates AngularJS module
  var TEMPLATES_NAME = 'appTemplates';
  // Where the built files would eventually live. If it's on its own domain,
  // this could be blank
  var ROOT = '';

  // Load the Pixbi embed
  var runLoader = function() {
    var vendor, app, templates, checkerId;

    // The vendor script first
    vendor = document.createElement('script');
    vendor.type = 'text/javascript';
    vendor.src = ROOT + '/vendor.js';

    // The templates then
    templates= document.createElement('script');
    templates.type = 'text/javascript';
    templates.src = ROOT + '/templates.js';

    // Finally the application script
    app = document.createElement('script');
    app.type = 'text/javascript';
    app.src = ROOT + '/app.js';

    // Add to vendor script, app stylesheet, and the Pixbi box
    document.body.appendChild(vendor);

    // Prepare controller declaration
    document.body.setAttribute('ng-controller', 'ApplicationController');

    checkerId = window.setInterval(function() {
      // Only when AngularJS is available
      if (window.angular !== void 0) {
        // Do we load our templates
        document.body.appendChild(templates);
        // And stop checking of course
        window.clearInterval(checkerId);

        checkerId = window.setInterval(function() {
          try {
            // Only when the templates are loaded
            angular.module(TEMPLATES_NAME);
            // Do we load our application code
            document.body.appendChild(app);
            // And stop checking already!
            window.clearInterval(checkerId);

            checkerId = window.setInterval(function() {
              try {
                // Only when the application is ready
                angular.module(APP_NAME);
                // Do we make this page AngularJS-enabled
                angular.bootstrap(document.body, [APP_NAME]);

                // Stop checking once again
                window.clearInterval(checkerId);
              } catch (error) {
                // Look for this error message for not finding the application module
                var appNotFound = new RegExp("[$injector:nomod] Module '" + APP_NAME);

                // Throw error if it's not missing the module
                if (error.message.match(appNotFound) === null) {
                  throw error;
                }
              }
            }, 50);
          } catch (error) {
            // Look for this error message for not finding the templates module
            var templatesNotFound = new RegExp("[$injector:nomod] Module '" + TEMPLATES_NAME);

            // Throw error if it's not missing the module
            if (error.message.match(templatesNotFound) === null) {
              throw error;
            }
          }
        }, 50);
      }
    }, 50);
  };

  // Handle this loader being dynamically loaded into the page
  if (document.readyState === 'complete') {
    runLoader();

  // Handle this loader being loaded with the rest of the page
  } else {
    // Standard
    if (window.addEventListener != null) {
      window.addEventListener('load', runLoader, false);
    // IE
    } else if (window.attachEvent != null) {
      window.attachEvent('onload', runLoader);
    // Old school
    } else {
      window.onload = runLoader;
    }
  }
})();
