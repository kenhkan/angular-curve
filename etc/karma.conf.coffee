module.exports = (config) ->
  config.set
    # base path, that will be used to resolve files and exclude
    basePath: '..'

    # required frameworks
    frameworks: [
      'jasmine'
    ]

    # list of files / patterns to load in the browser
    files: [
      # Dependencies
      'public/vendor.js'
      # Templates
      'public/templates.js'
      # Application code
      'public/app.js'
      # Spec code
      'public/spec.js'
    ]

    # files to preprocess before testing
    preprocessors:
      '**/*.coffee': ['coffee']

    coffeePreprocessor:
      options:
        bare: true
        sourceMap: true
      transformPath: (path) ->
        return path.replace /\.coffee$/, '.js'

    # use dots reporter, as travis terminal does not support escaping sequences
    # possible values: 'dots', 'progress'
    # CLI --reporters progress
    reporters: ['dots']

    # web server port
    # CLI --port 9876
    port: 9876

    # enable / disable colors in the output (reporters and logs)
    # CLI --colors --no-colors
    colors: true

    # level of logging
    # possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
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

    # report which specs are slower than 500ms
    # CLI --report-slower-than 500
    reportSlowerThan: 500
