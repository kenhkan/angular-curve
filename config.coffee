glob = require 'glob'

# See docs at https://github.com/brunch/brunch/blob/stable/docs/config.md
exports.config =
  conventions:
    assets: /^app\/assets\//

  # No wrapping
  modules:
    definition: false
    wrapper: false

  files:
    javascripts:
      joinTo:
        # Non-spec scripts are application code
        'app.js': /^app\/(?!.+\.spec\.)/
        # Specs are compiled into another file by themselves
        'spec.js': /^app\/.+\.spec\./
        # Vendor code
        'vendor.js': /^(bower_components|vendor)\/(?!.+\.spec\.)/
      order:
        before: [
          # Essential libraries
          'bower_components/lodash/lodash.js'
          'bower_components/jquery/jquery.js'
          'bower_components/angular/angular.js'
        # Entry point. Put your AngularJS module definition here
        ].concat glob.sync 'app/index.*'

    stylesheets:
      joinTo:
        'app.css': /^app/
        'vendor.css': /^(bower_components|vendor)/

    templates:
      joinTo:
        'templates.js': /^app/

  plugins:

    ## Scripts

    coffeescript:
      # Auto-wrap in self-calling function
      bare: false

    ## Styles

    autoprefixer:
      # Definitely no IE6, but IE7?
      browsers: ["last 1 version", "> 1%", "ie 8", "ie 7"]
