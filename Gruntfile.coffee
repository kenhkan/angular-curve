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
        browsers: ['']
      continuous:
        singleRun: true

    # Concurrently run watch and server
    concurrent:
      options:
        limit: 3
        logConcurrentOutput: true
      # When developing, just run the server and watch for changes
      develop: [
        # Start the Karma server
        'karma:unit:start'
        # Re-assemble on change
        'exec:brunchWatch'
        # Run tests on change
        'watch:test'
      ]

    ## Execute arbitrary commands

    exec:
      # Compile for development with Brunch
      brunchCompile:
        cmd: 'node_modules/.bin/brunch build'
      # Build for production with Brunch
      brunchBuild:
        cmd: 'node_modules/.bin/brunch build -P'
      # Watch for changes for re-assembly
      brunchWatch:
        cmd: 'node_modules/.bin/brunch watch --server'

  ## Build tasks

  # Usually you just want to run `grunt` to enter development mode
  grunt.registerTask 'default', [
    'concurrent:develop'
  ]

  # Continuous integration mode
  grunt.registerTask 'continuous', [
    'exec:brunchCompile'
    'karma:continuous:start'
  ]

  # Build for production
  grunt.registerTask 'build', [
    'exec:brunchBuild'
  ]
