module.exports = (grunt) ->
  # Paths
  sourceDir = 'app' # Where the source lives
  configDir = 'etc' # Where to put config files

  # Load Grunt tasks
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-conventional-changelog'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-bump'
  grunt.loadNpmTasks 'grunt-exec'
  grunt.loadNpmTasks 'grunt-karma'
  grunt.loadNpmTasks 'grunt-concurrent'
  grunt.loadNpmTasks 'grunt-docker'

  # Configuration
  grunt.initConfig
    # Package metadata
    pkg: grunt.file.readJSON 'package.json'

    # Automatic changelog
    changelog:
      options:
        dest: 'CHANGELOG.md'
        template: 'etc/changelog.tpl'

    # Bump version to both Bower and NPM
    bump:
      options:
        files: ['package.json', 'bower.json']
        commit: false
        commitMessage: 'chore(release): v%VERSION%'
        commitFiles: ['package.json', 'client/bower.json']
        createTag: false
        tagName: 'v%VERSION%'
        tagMessage: 'Version %VERSION%'
        push: false
        pushTo: 'origin'

    # Documentation
    docker:
      app:
        src: 'app'
        dest: 'doc'
        options:
          extras: ['fileSearch', 'goToLine']

    # Clean house
    clean:
      build: ['public']

    # Watch
    watch:
      options:
        livereload: true
      # Run test case
      test:
        files: ["#{sourceDir}/**/*"]
        tasks: ['karma:unit:run']

    # Testing
    karma:
      options:
        configFile: "#{configDir}/karma.conf.coffee"
        browsers: ['PhantomJS']
        reporters: 'dots'
      unit:
        browsers: -> false
      ci:
        singleRun: true

    # Concurrently run development and test servers
    concurrent:
      options:
        logConcurrentOutput: true
      develop: ['exec:watch', 'karma:unit:start']

    # Execute arbitrary commands
    exec:
      # Compile without further processing
      compile:
        cmd: 'node_modules/.bin/brunch build',
      # Build for production
      build:
        cmd: 'node_modules/.bin/brunch build -P',
      # Watch for changes for re-assembly
      watch:
        cmd: 'node_modules/.bin/brunch watch --server'
      # Install Bower
      bower:
        cmd: 'node_modules/.bin/bower install'

  ## Build tasks

  # Usually you just want to run `grunt` to enter development mode, which
  # re-assembles on change
  grunt.registerTask 'default', [
    'clean'
    'concurrent:develop'
  ]

  # Just run server and watch files
  grunt.registerTask 'server', [
    'exec:watch'
  ]

  # Test mode
  grunt.registerTask 'test', [
    'clean'
    'karma:unit:start'
  ]

  # Continuous integration mode
  grunt.registerTask 'ci', [
    'clean'
    'karma:ci:start'
  ]

  # Compile, don't build, as we don't want the files to be minified
  grunt.registerTask 'build', [
    'clean'
    'exec:compile'
    'docker'
  ]

  # Procedure post-install for NPM
  grunt.registerTask 'postinstall', [
    'exec:bower'
    'build'
  ]
