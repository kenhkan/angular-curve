# Angular Curve: The Smoothest AngularJS Boilerplate <br/>[![Dependency Status](https://david-dm.org/kenhkan/angular-curve.png)](https://david-dm.org/kenhkan/angular-curve) [![Stories in Ready](https://badge.waffle.io/kenhkan/angular-curve.png)](http://waffle.io/kenhkan/angular-curve)

You should be able to develop AngularJS without having to set anything up. This
is an opinionated workflow in developing front-end project with AngularJS. If
you have an opinion on a best practice to employ, please send in a pull
request!


## Motivation

For AngularJS development,
[angular-seed](https://github.com/angular/angular-seed) is a great starting
point. [ngBoilerplate](https://github.com/ngbp/ng-boilerplate) is a fantastic
improvement over angular-seed. Though you still need to install a bunch of
dependencies and tinker with the Gruntfile somewhat.

Rather than handling everything as a monolithic asset pipeline, ng-brunch
offloads the assembly workflow to [Brunch](http://brunch.io/). You need
additional language support? Check out the [Brunch plugins
page](https://github.com/brunch/brunch/wiki/Plugins), do a `npm install`, and
you're set.


## Best Practices

* Entirely [Grunt](http://gruntjs.com/)-based: you only need one interface
* [Docco](http://jashkenas.github.io/docco/)-style documentation that expects
  [JSDoc](http://usejsdoc.org/)
* [Bower](http://bower.io/)-powered package management
* Dead-easy, drop-in support of your favorite preprocessors and tools with
  [Brunch](http://brunch.io/). See [supported file types](#supportedfiletypes)
  for more info
* [Heroku](https://www.heroku.com) for staging. This project can host itself
  on Heroku out of the box
* Follow [JavaScript Style
  Guide](http://google-styleguide.googlecode.com/svn/trunk/javascriptguide.xml)
* Follow [CoffeeScript Style
  Guide](https://github.com/polarmobile/coffeescript-style-guide)
* Follow [general CSS notes, advice, and
  guidelines](https://github.com/csswizardry/CSS-Guidelines)
* Commits follow [AngularJS Git Commit Message
  Conventions](https://docs.google.com/document/d/1QrDFcIiPjSLDn3EL15IJygNPiHORgU1_OOAqWjiDU5Y)
* Use [IcoMoon](http://icomoon.io/) for application graphic assets in SVG


## Installation

This is simply a boilerplate. `git clone` or `git remote add` this repository
to continue.  And then:

1. I assume you have [Node.js/NPM](http://nodejs.org/)
2. You need [Grunt](http://gruntjs.com/): `npm install -g grunt-cli`
3. You also need Bower: `npm install -g bower`
4. Install Pygments so that [Docker](https://github.com/jbt/docker) can
   generate documentation for you, docco-style: `pip install pygments`
5. Get NPM deps: `npm install`
6. Get Bower deps: `bower install`
7. In `app/assets/index.html`, remember to configure your project by playing
   around with the `window.CURVE_APP` global variable.


## Configuration

Configuration is done via the `window.CURVE_APP` global object. Available
configuration:

* `name`: The application name that will be registered with Angular. Use this
  other than hard-coding your application name as that saves you from having to
  go into the loader and hard-code the name there.
* `base`: This is the base URL to load the rest of the assets. Default to the
  current domain
* `element`: This is the root element that the loader will bootstrap on.
  Default to the `document.body` element


## Usage

1. Run `grunt` to get Karma running, watching for file changes, and a server
   running in the background
2. Open `localhost:8888` in the newly Karma-opened browser to view your app

### `grunt`

Development mode:

* Start watching for file changes
* Spin up a local webserver on `localhost:8888`
* Start up Karma at `localhost:9876`

### `grunt server`

Server watch mode. Like development mode but without test server (i.e.
Karma). Files are updated and served on `localhost:8888`

### `grunt test`

Test mode. This is like development mode with a local webserver and Karma,
except that it runs only once, designed for continuous integration

### `grunt compile`

Compile the app

### `grunt watch`

Watch for file changes in source and re-compile. This is a `grunt compile` that
runs on file change.

### `grunt build`

Build the app in production mode (compiled + minified + uglified). When
building, everything under `public/_dev` directory will be removed, so
non-production code (e.g. testing setup code) would live happily in
`public/_dev`.

### `grunt clean`

This resets the project to its pristine state.

### `grunt release`

Release a new version. It does a few things:

1. Perform a full build
2. Rebuild documentation using Docker
3. Bump version: see [version bumping](https://github.com/vojtajina/grunt-bump)
4. Build changelog: see [changelog
   building](https://github.com/btford/grunt-conventional-changelog)
5. Make a commit with version number, [semvar style](http://semver.org/)
6. Tag the commit with version number
7. Push to remote `origin`


## File structure

After having set up the project, the file structure would look like:

    app/ -> Anything specific to the app goes here
    app/assets/ -> Anything here is copied over to top-level directory as-is
    app/assets/index.html -> The index page
    app/assets/loader.js -> This is the bootstrapper that starts it all
    app/common/ -> Run before everything else in `app/`
    app/application.coffee -> The top-level controller
    app/application.spec.coffee -> Sample test cases for ApplicationController
    app/index.coffee -> The entry point, where module definition takes place
    bower_compoennts/ -> Downloaded Bower components
    etc/karma.conf.coffee -> The Karma configuration file
    node_modules/ -> downloaded NPM modules
    public/ -> The built files lives here
    bower.json -> Bower dependency declaration
    Gruntfile.coffee -> Gruntfile configuration
    LICENSE -> Pretty self-explanatory
    package.json -> NPM dependency declaration
    README.md -> This document


## Bootstrapping order

angular-curve loads everything asynchronously. Here's what it does to bootstrap
the application:

1. `index.html` sets all the required parameters specific to the app (via
   `window.CURVE_APP`, see the [Configuration](#configuration) section)
2. `loader.js` then fill in the blanks for parameters that are not provided
   values; then make the [LazyLoad](https://github.com/rgrove/lazyload) library
   available; then loads all the style and script files
3. AngularJS then bootstraps the application on the base element, default to
   `document.body`
4. At this point, Angular has control and `index.coffee` is run, then
   `application.coffee` and so forth


## Supported file types

Anything found in the Brunch plugin ecosystem is supported! By default this
application supports:

* CSS/JS: `.css`, `.js` (duh!)
* CoffeeScript: `.coffee`
* Literate CoffeeScript: `.litcoffee`
* SASS: `.sass`
* LESS: `.less`
* Stylus: `.styl`
* Handlebars: `.hbs`
* Eco: `.eco`
* Jade: `.jade`

Add more by running `npm install --save yourDesiredFileTypeHere-brunch`.
Search on NPM with `yourDesiredFileTypeHere brunch` for the correct NPM module.
Or visit the [plugin directory](https://github.com/brunch/brunch/wiki/Plugins)
to hunt for your gems!

If you add a new template preprocessor, remember to add the relevant extensions
to `curve.templates.extensions` in `bower.json` as angular-curve needs to know
which files are templates to prepend `app.js`.

Under the `app` directory:

* Script files are compiled into one JavaScript file, `public/app.js`
* Test files in JavaScript/CoffeeScript (`*.spec.js` and `*.spec.coffee`) are
  compiled into the file `public/spec.js`
* Style files are compiled into one CSS file `public/app.css`
* Markup files are compiled into template-containing JavaScript into
  `public/app.js`.


## Custom build paths

You can designate specific source files to be built to a specific output file.
For instance, angular-curve by default builds angular-mocks to the file
`public/vendor_test.js`. angular-mocks should not be part of the general
`vendor.js` file because it is not needed in production.

You may optionally define your own build paths by modifying the `bower.json`
file. Specifically, add the output file name without extension as the key of
the object `splitTo` with the value being an array of files to build to the
specified output file. angular-curve will exclude these files from any of the
normal output files: `app.js` and `vendor.js`.

A `before` and `after` may be used in an `order` attribute. Files at the paths
specified in those two attributes are placed either before or after the rest of
the script files.

The following configuration would put the content of
`app/somewhere/called/home.js` and `app/welcome.js` (this first) into
`public/local.js` and `app/where/am/i.js` into `public/remote.js`.

```
  ...
  "curve": {
    "javascripts": {
      "order": {
        "before": {
          "app/welcome.js"
        }
      },
      "splitTo": {
        "local": [
          "app/somewhere/called/home.js",
          "app/welcome.js",
        ],
        "remote": [
          "app/where/am/i.js"
        ]
      }
    }
  }
  ...
```


## Package management

Because developing in Angular requires many external libraries, package
management should be automated using [Bower](http://bower.io/). Follow these
steps:

1. Find the package you want by running `bower search <package-name>`
2. `bower install --save <package-name>`
3. That's it! :D

### In Development

Remember that Bower provides a powerful `bower link` facility. If you are
including another Bower-enabled repo, simply run `bower link` in that repo's
root directory and then `bower link <nameAsInBowerJsonHere>` in the dependent
directory. Locally linked repos greatly simplify the development process.


## App file structure

There is no convention here. Scripts, styles, and markups are compiled to
`public/`. Anything under `assets/` is treated as assets and are transferred
as-is to the top-level directory under `public/`.

Source maps of the compiled files are available in development mode.


## Feature Notes

* [compass](http://compass-style.org/): configure Compass by defining
  `$GEM_HOME` on your command-line or in `config.coffee`. Check
  [sass-brunch](https://github.com/brunch/sass-brunch#options) for more info
* [Docker](http://jbt.github.io/docker/): generate documentation on build. Note
  that Docker only recognizes JSDoc declaration when it's in a block-style
  comment (i.e. `/* ... */` in JavaScript and `### ... ###` in CoffeeScript)
* [autoprefixer](https://github.com/lydell/autoprefixer): uses [Can I
  use](http://caniuse.com) to autoprefix your CSS
* [cache
  manifest](https://developer.mozilla.org/en-US/docs/HTML/Using_the_application_cache#The_cache_manifest_file):
  you should always include a manifest so that the browser knows what to cache.
  angular-curve uses
  [appcache-brunch](https://github.com/brunch/appcache-brunch#settings) to
  build the manifest


## Documentation

Documentation is generated into the `doc/` directory. However, generated files
are not checked into source. You must deal with the output yourself. In the
future, this will push directly to a configured AWS S3 bucket (#9).


## Staging on Heroku

This project is Heroku-ready. Simply add a Heroku multipack buildpack:

    heroku config:set BUILDPACK_URL=https://github.com/ddollar/heroku-buildpack-multi
