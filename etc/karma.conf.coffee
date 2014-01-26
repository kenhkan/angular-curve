module.exports = (config) ->
  config.set
    # Base path, that will be used to resolve files and exclude
    basePath: '..'

    # Required frameworks
    frameworks: [
      'jasmine'
    ]

    # Load the entire thing
    files: [
      'public/loader.js'
      'public/vendor.js'
      'public/_dev/test_lib.js'
      'public/app.js'
      'public/_dev/spec.js'
    ]

    # Files to preprocess before testing
    preprocessors:
      '**/*.coffee': ['coffee']

    coffeePreprocessor:
      options:
        bare: true
        sourceMap: true
      transformPath: (path) ->
        return path.replace /\.coffee$/, '.js'

    # Use dots reporter, as travis terminal does not support escaping sequences
    # Possible values: 'dots', 'progress'
    # CLI --reporters progress
    reporters: ['dots']

    # Web server port
    # CLI --port 9876
    port: 9876

    # Enable / disable colors in the output (reporters and logs)
    # CLI --colors --no-colors
    colors: true

    # Level of logging
    # Possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    # CLI --log-level debug
    logLevel: config.LOG_INFO

    # enable / disable watching file and executing tests whenever any file changes
    # CLI --auto-watch --no-auto-watch
    autoWatch: false

    # Start these browsers, currently available:
    # - Chrome
    # - ChromeCanary
    # - Firefox
    # - Opera
    # - Safari (only Mac)
    # - PhantomJS
    # - IE (only Windows)
    # CLI --browsers Chrome,Firefox,Safari
    browsers: ['PhantomJS']

    # If browser does not capture in given timeout [ms], kill it
    # CLI --capture-timeout 5000
    captureTimeout: 20000

    # Auto run tests on start (when browsers are captured) and exit
    # CLI --single-run --no-single-run
    singleRun: false

    # Report which specs are slower than 500ms
    # CLI --report-slower-than 500
    reportSlowerThan: 500
