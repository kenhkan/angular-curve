glob = require 'glob'
Lazy = require 'lazy.js'

# The `bower.json` config file
bower = require './bower'
# Acceptable template extensions
TEMPLATE_EXTENSIONS = bower.curve.templates.extensions

# See docs at https://github.com/brunch/brunch/blob/stable/docs/config.md
exports.config =
  conventions:
    assets: /^app\/assets\//

  # We use AngularJS' own DI mechanism
  modules:
    definition: false
    wrapper: false

  server:
    port: 8888

  files:
    javascripts:
      joinTo:
        # Non-spec scripts are application code
        'app.js': /^app\/(?!.+\.spec\.)/
        # Specs are compiled into another file by themselves
        '_dev/spec.js': /^app\/.+\.spec\./
        # Vendor code
        'vendor.js': /^(bower_components)\/(?!.+\.spec\.)/
      order:
        after: bower.curve.javascripts.after or []

        before: (glob.sync(
          # Templates first
          "app/**/*.+(#{TEMPLATE_EXTENSIONS})"

        )).concat(
          # Essential libraries to load before the rest
          bower.curve.javascripts.before or []

        ).concat(glob.sync(
          # Library files first
          'bower_components/**/*.js'

        )).concat(glob.sync(
          # Main entry point
          'app/index.*'

        )).concat(glob.sync(
          # Individual entry points
          'app/**/index.*'

        )).concat(glob.sync(
          # Project-specific shared libraries
          'app/common/**/*'
        ))

    stylesheets:
      joinTo:
        'app.css': /^app/
        'vendor.css': /^(bower_components)/

    templates:
      joinTo:
        'app.js': /^app/

  plugins:
    coffeescript:
      # Auto-wrap in self-calling function
      bare: false

    appcache:
      ignore: /_dev/


# Process the JavaScript `joinTo` object to separate out user-defined `splitTo`
# files (defined in `bower.json`)
joinTo = exports.config.files.javascripts.joinTo
splitTo = bower.curve.javascripts.splitTo
# All the `splitTo`s, flattened
splitTos = Lazy(splitTo).values().flatten()

# Each `joinTo` should exclude those in `splitTo`
Lazy(joinTo).each (pattern, path) ->
  # Substitute the pattern with a function that matches the pattern as well as
  # excludes `splitTo` paths
  joinTo[path] = (file) ->
    # It must match the original pattern but not in `splitTo`s
    file.match(pattern)? and not splitTos.contains(file)

# Also construct new `joinTo` based on `splitTo`
Lazy(splitTo).each (paths, name) ->
  paths = Lazy paths
  joinTo["#{name}.js"] = (file) ->
    paths.contains file
