# Angular Curve: The Smoothest Development Framework <br/>[![Dependency Status](https://david-dm.org/kenhkan/angular-curve.png)](https://david-dm.org/kenhkan/angular-curve) [![Stories in Ready](https://badge.waffle.io/kenhkan/angular-curve.png)](http://waffle.io/kenhkan/angular-curve)

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
* [Harp](https://www.harp.io/) for worry-free production hosting
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
3. Install Pygments so that [Docker](https://github.com/jbt/docker) can
   generate documentation for you, docco-style: `pip pygments`
4. Get NPM deps: `npm install`
5. Get Bower deps: `bower install`
6. In `app/assets/index.html`, configure the app by specifying your app name,
   base URL, etc. This file is the entry point. Add any static references here
   and a copy of which will be produced upon building to `404.html` to ensure
   not-found errors are catched by AngularJS.


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

Build the app in production mode (compile + minified + uglified)

### `grunt clean`

This resets the project to its pristine state.

### `grunt production`

Run server as if it is in production. The opinionated angular-curve assumes
production will be a [Harp app](harp.io).

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
    app/assets/ -> Anything here is copied over to top-level directory as-is.
    app/assets/index.html -> The entry point index page
    app/assets/config.js -> This script is executed before AngularJS is loaded
    app/assets/init.js -> This is the script that loads the application
    app/assets/loader.js -> This is the bootstrapper that starts it all
    app/common/ -> Included before everything else in `app/`
    app/application.coffee -> The top-level ApplicationController
    app/application.spec.coffee -> Test cases for ApplicationController
    app/index.coffee -> The main entry point, where module definition takes place
    bower_compoennts/ -> Downloaded Bower components
    etc/karma.conf.coffee -> The Karma configuration file
    node_modules/ -> downloaded NPM modules
    public/ -> The built code lives here
    bower.json -> Bower dependency declaration
    Gruntfile.coffee -> Gruntfile configuration
    LICENSE -> Pretty self-explanatory
    package.json -> NPM dependency declaration
    README.md -> This document


## Bootstrapping order

This application lazy loads everything necessary. Here's what it does to
bootstrap the application:

1. `index.html` sets all the required parameters specific to the app
2. `loader.js` then sets forth basic bootstrapping parameters like the base
   URL, make the [LazyLoad](https://github.com/rgrove/lazyload) library available,
   and load `init.js` lazily
3. `init.js` sets more parameters and loads `vendor.js`, `templates.js`,
   `config.js`, and `app.js`, in that order
4. `vendor.js`, `templates.js`, and `app.js` are compiled scripts from the
   source and `config.js` is a custom script in `app/assets/` to allow
   configuration before the application loads.
5. AngularJS then bootstraps the application on the provided base element,
   default to the body
6. At this point, AngularJS has control and `index.coffee` is run, then
   `application.coffee` and so forth


## Supported file types

Anything found in the Brunch plugin ecosystem is supported! By default this
repo supports:

* CSS/JS: `.css`, `.js` (duh!)
* CoffeeScript: `.coffee`
* Literate CoffeeScript: `.litcoffee`
* SASS: `.sass`
* LESS: `.less`
* Stylus: `.styl`
* Handlebars: `.hbs`
* Eco: `.eco`
* Jade: `.jade`
* Mardown: `.md`

Add more by running `npm install --save yourDesiredFileTypeHere-brunch`.
Search on NPM with `yourDesiredFileTypeHere brunch` for the correct NPM module.
Or visit the [plugin directory](https://github.com/brunch/brunch/wiki/Plugins)
to hunt for your gems!

Under the `app` directory:

* Script files are compiled into one JavaScript file, `public/app.js`
* Test files in JavaScript/CoffeeScript (`*.spec.js` and `*.spec.coffee`) are
  compiled into the file `public/spec.js`
* Style files are compiled into one CSS file `public/app.css`
* Markup files are compiled into one template-containing JavaScript file
  `public/templates.js`


## Package management

Because developing in Angular.js requires many external libraries, package
management should be automated using [Bower](http://bower.io/). Follow these
steps:

1. Find the package you want by running `bower search <package-name>`
2. `bower install --save <package-name>`
3. That's it! :D

### In Development

Remember that Bower provides a powerful `bower link` facility. If you are
including on another Bower-enabled repo, simply run `bower link` in that repo's
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
  comment (i.e. `/* ... */`)
* [autoprefixer](https://github.com/lydell/autoprefixer): uses [Can I
  use](http://caniuse.com) to autoprefix your CSS


## Documentation

Documentation is generated into the `doc/` directory. However, generated files
are not checked into source. You must deal with the output yourself. In the
future, this will push directly to a configured AWS S3 bucket (#9).


## Staging on Heroku

angular-curve is Heroku-ready. Simply add a Heroku multipack buildpack:

    heroku config:set BUILDPACK_URL=https://github.com/ddollar/heroku-buildpack-multi
