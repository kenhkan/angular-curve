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
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-bump'
  grunt.loadNpmTasks 'grunt-karma'
  grunt.loadNpmTasks 'grunt-docker'
  grunt.loadNpmTasks 'grunt-shell-spawn'

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
        commitFiles: ['-a']
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

    # Watch
    watch:
      options:
        livereload: true
      # Run test case
      test:
        files: ["#{SOURCE_DIR}/**/*"]
        tasks: ['karma:unit:run']

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

    # Execute arbitrary commands
    shell:
      options:
        stdout: true
        stderr: true
      # Compile without further processing
      compile:
        command: 'node_modules/.bin/brunch build',
      # Build for production
      build:
        command: 'node_modules/.bin/brunch build -P',
      # Watch for changes for re-assembly
      watch:
        options:
          async: true
        command: 'node_modules/.bin/brunch watch --server'

  ## Build tasks

  # Usually you just want to run `grunt` to enter development mode, which
  # re-assembles on change
  grunt.registerTask 'default', [
    'clean'
    # Compile once for Karma (`shell:watch` may not have compiled in time as
    # the it runs concurrently)
    'shell:compile'
    # Then run Brunch and Karma
    'shell:watch'
    'karma:unit:start'
  ]

  # Just run server and watch files
  grunt.registerTask 'server', [
    'clean'
    'shell:watch'
  ]

  # Test mode. This is for continuous integration. To run tests locally, just
  # run `grunt`
  grunt.registerTask 'test', [
    'clean'
    'shell:compile'
    # A local webserver may be used for testing
    'shell:watch'
    'karma:ci:start'
    # But terminate the local webserver after testing is done
    'shell:watch:kill'
  ]

  # Build -- minify and uglify
  grunt.registerTask 'build', [
    'clean'
    'shell:build'
    'copy:404'
  ]

  # Release -- new version!
  grunt.registerTask 'release', (type) ->
    grunt.task.run [
      'build'
      'docker'
      "bump-only:#{type or 'patch'}"
      'changelog'
      'bump-commit'
    ]
