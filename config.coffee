exports.config =
  # See docs at http://brunch.readthedocs.org/en/latest/config.html.
  conventions:
    assets: /^app\/assets\//
  modules:
    definition: false
    wrapper: false
  paths:
    public: 'public'
    jadeCompileTrigger: '_jade_templates.js'
  files:
    javascripts:
      joinTo:
        # Non-spec scripts are application code
        'app.js': /^app\/(?!.+\.spec\.)/
        # Specs are compiled into another file by themselves
        'spec.js': /^app\/.+\.spec\./
        # Anything managed by Bower is vendor code
        'vendor.js': /^(bower_components|vendor)/
      order:
        before: [
          # Essential libraries
          'bower_components/lodash/lodash.js'
          'bower_components/jquery/jquery.js'
          'bower_components/angular/angular.js'
          # Entry point
          'app/main.coffee'
        ]

    stylesheets:
      joinTo:
        'app.css': /^app/
        'vendor.css': /^(bower_components|vendor)/

    templates:
      joinTo:
        '_jade_templates.js': /^app/

  plugins:
    jade_angular:
      static_mask: /index/
      # All templates should be in one single file
      single_file: true
      single_file_name: 'templates.js'
    process_env:
      raw: true
    coffeescript:
      bare: false
