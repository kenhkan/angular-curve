exports.config =
  # See docs at http://brunch.readthedocs.org/en/latest/config.html.
  conventions:
    assets: /^app\/assets\//
  modules:
    definition: false
    wrapper: false
  paths:
    public: 'public'
  files:
    javascripts:
      joinTo:
        # Non-spec scripts are application code
        'app.js': /^(app|bower_components|vendor)\/(?!.+\.spec\.)/
        # Specs are compiled into another file by themselves
        'spec.js': /^app\/.+\.spec\./
      order:
        before: [
          # Essential libraries
          'bower_components/lodash/lodash.js'
          'bower_components/jquery/jquery.js'
          'bower_components/angular/angular.js'
          # Entry point
          'app/index.coffee'
        ]

    stylesheets:
      joinTo:
        'app.css': /^(app|bower_components|vendor)/

    templates:
      joinTo:
        'templates.js': /^app/

  plugins:
    process_env:
      raw: true
    coffeescript:
      bare: false
