glob = require 'glob'

# See docs at https://github.com/brunch/brunch/blob/stable/docs/config.md
exports.config =
  conventions:
    assets: /^app\/assets\//

  # AMD - We use RequireJS
  modules:
    definition: 'amd'
    wrapper: 'amd'

  server:
    port: 8888

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
          'bower_components/lodash/dist/lodash.js'
          'bower_components/jquery/jquery.js'
          'bower_components/angular/angular.js'
        ]
        # Vendor files
        .concat(glob.sync 'bower_components/**/*.js')
        # Entry point. Put your AngularJS module definition here
        .concat(glob.sync 'app/index.*')
        # Common scripts take precedence
        .concat(glob.sync 'app/common/**/*')

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
