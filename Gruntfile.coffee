module.exports = (grunt) ->
  # Paths
  SOURCE_DIR = 'app'
  CONFIG_DIR = 'etc'
  BUILD_DIR = 'public'
  DOC_DIR = 'doc'

  # Port to use to run the local webserver
  PORT = process.env.LOCAL_PORT or 8888

  # Load Grunt tasks
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-conventional-changelog'
  grunt.loadNpmTasks 'grunt-bump'
  grunt.loadNpmTasks 'grunt-karma'
  grunt.loadNpmTasks 'grunt-docker'
  grunt.loadNpmTasks 'grunt-shell-spawn'
  grunt.loadNpmTasks 'grunt-brunch'

  # Configuration
  grunt.initConfig
    # Package metadata
    pkg: grunt.file.readJSON 'package.json'

    # Bump version to both Bower and NPM
    bump:
      options:
        files: ['package.json', 'bower.json']
        commit: true
        commitMessage: 'chore(release): v%VERSION%'
        commitFiles: ['package.json', 'bower.json', 'CHANGELOG.md']
        createTag: true
        tagName: 'v%VERSION%'
        tagMessage: 'Version %VERSION%'
        push: true
        pushTo: 'origin'

    # Documentation
    docker:
      app:
        src: SOURCE_DIR
        dest: DOC_DIR
        options:
          extras: ['fileSearch', 'goToLine']

    # Clean house
    clean:
      build: [BUILD_DIR]
      excess: [
        "#{BUILD_DIR}/spec.js"
        "#{BUILD_DIR}/_dev/"
      ]

    # Testing
    karma:
      options:
        configFile: "#{CONFIG_DIR}/karma.conf.coffee"
        browsers: ['PhantomJS']
        reporters: 'dots'
      unit:
        browsers: -> false
      ci:
        singleRun: true

    copy:
      # Copy over index as 404
      '404':
        src: "#{BUILD_DIR}/index.html"
        dest: "#{BUILD_DIR}/404.html"

    # Brunch commands
    brunch:
      serve:
        action: 'serve'
        port: PORT
      serveAsync:
        action: 'serve'
        port: PORT
        async: true
      watch:
        action: 'watch'
        port: PORT
      compile:
        action: 'compile'
      build:
        action: 'build'

    # Execute arbitrary commands
    shell:
      options:
        stdout: true
        stderr: true

  ## Build tasks

  # Usually you just want to run `grunt` to enter development mode, which
  # re-assembles on change
  grunt.registerTask 'default', [
    'clean'
    'brunch:compile' # Compile once for Karma
    'brunch:serveAsync' # ... because this async op will not compile in time
    'karma:unit:start'
  ]

  # Just run server and watch files to serve
  grunt.registerTask 'server', [
    'clean'
    'brunch:serve'
  ]

  # Test mode. This is for continuous integration. To run tests locally, just
  # run `grunt`
  grunt.registerTask 'test', [
    'clean'
    'brunch:compile'
    'brunch:serveAsync' # A local webserver may be used for testing
    'karma:ci:start'
  ]

  # JUST watch for file changes. Don't run server
  grunt.registerTask 'watch', [
    'clean'
    'brunch:watch'
    'copy:404'
  ]

  # JUST compile, nothing else
  grunt.registerTask 'compile', [
    'clean'
    'brunch:compile'
    'copy:404'
  ]

  # Build -- minify and uglify
  grunt.registerTask 'build', [
    'clean'
    'brunch:build'
    'copy:404'
    'clean:excess'
  ]

  # Simply compile on heroku
  grunt.registerTask 'heroku', ['compile']

  # Release -- new version!
  grunt.registerTask 'release', (type) ->
    grunt.task.run [
      'build'
      'docker'
      "bump-only:#{type or 'patch'}"
      'changelog'
      'bump-commit'
    ]
