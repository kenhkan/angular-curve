module.exports = (grunt) ->
  # Paths
  SOURCE_DIR = 'app'
  CONFIG_DIR = 'etc'
  BUILD_DIR = 'public'
  DOC_DIR = 'doc'

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
      index: ["#{BUILD_DIR}/index.html"]

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
        src: "#{BUILD_DIR}/index.jade"
        dest: "#{BUILD_DIR}/404.jade"

    # Brunch commands
    brunch:
      serve:
        action: 'serve'
        port: 8888
      serveAsync:
        action: 'serve'
        port: 8888
        async: true
      watch:
        action: 'watch'
        port: 8888
      compile:
        action: 'compile'
      build:
        action: 'build'

    # Execute arbitrary commands
    shell:
      options:
        stdout: true
        stderr: true
      # Convert index to Jade for Harp
      html2jade:
        command: 'node_modules/.bin/html2jade app/assets/index.html'
      # Run Harp server (production mode)
      harp:
        command: "node_modules/.bin/harp server public --port #{process.env.PORT or '8888'}"

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
    'shell:html2jade'
    'brunch:watch'
    'copy:404'
    'clean:index'
  ]

  # JUST compile, nothing else
  grunt.registerTask 'compile', [
    'clean'
    'shell:html2jade'
    'brunch:compile'
    'copy:404'
    'clean:index'
  ]

  # Build -- minify and uglify
  grunt.registerTask 'build', [
    'clean'
    'shell:html2jade'
    'brunch:build'
    'copy:404'
    'clean:index'
  ]

  # Run server in production mode
  grunt.registerTask 'production', [
    'build'
    'shell:harp'
  ]

  # Build on heroku
  grunt.registerTask 'heroku', ['build']

  # Release -- new version!
  grunt.registerTask 'release', (type) ->
    grunt.task.run [
      'build'
      'docker'
      "bump-only:#{type or 'patch'}"
      'changelog'
      'bump-commit'
    ]
