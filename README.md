# Setup-free AngularJS Development Skeleton <br/>[![Dependency Status](https://david-dm.org/kenhkan/ng-brunch.png)](https://david-dm.org/kenhkan/ng-brunch) [![Stories in Ready](https://badge.waffle.io/kenhkan/ng-brunch.png)](http://waffle.io/kenhkan/ng-brunch)

You should be able to develop AngularJS without having to set anything up. This
skeleton makes it easy to get started and to evolve with your project!


## Motivation

For AngularJS development,
[angular-seed](https://github.com/angular/angular-seed) is a great starting
point. [ngBoilerplate](https://github.com/ngbp/ng-boilerplate) is a fantastic
improvement over angular-seed. Though you still need to install a bunch of
dependencies and tinker with the Gruntfile unless you follow the ngBoilerplate
way completely.

Rather than handling everything as a monolithic asset pipeline, ng-brunch
offloads the assembly workflow to [Brunch](http://brunch.io/). You need
additional language support? Check out the [Brunch plugins
page](https://github.com/brunch/brunch/wiki/Plugins) and you're set.


## Installation

1. Clone this repo (of course): `git clone
   https://github.com/kenhkan/ng-brunch.git`
2. I assume you have [Node.js/NPM](http://nodejs.org/)
3. You need [Grunt](http://gruntjs.com/): `npm install -g grunt-cli`
4. Install Pygments so that [Docker](https://github.com/jbt/docker) can
   generate documentation for you, docco-style: `pip pygments`
5. Get NPM deps: `npm install`
6. Get Bower deps: `bower install`
7. Replace `myApplication` with your app name in `app/assets/loader.js` and script
   files under `app/`. This will be automated in a setup script in the future.

Or, if you're on a POSIX system, run the one-line setup script that bootstraps
the project and run a server at `localhost:8888`: `./setup.sh`


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

Test mode: start up Karma at `localhost:9876`

### `grunt ci`

Continuous mode: run Karma once for testing on Travis, Jenkins, etc

### `grunt build`

Production mode: build the app in production mode (minified and uglified)

### `grunt clean`

This resets the project to its pristine state.

### `grunt changelog`

See [changelog building](https://github.com/btford/grunt-conventional-changelog)

### `grunt bump`

See [version bumping](https://github.com/vojtajina/grunt-bump)


## Style

* Follow [JavaScript Style
  Guide](http://google-styleguide.googlecode.com/svn/trunk/javascriptguide.xml)
* Follow [CoffeeScript Style
  Guide](https://github.com/polarmobile/coffeescript-style-guide)
* Commits follow [AngularJS Git Commit Message
  Conventions](https://docs.google.com/document/d/1QrDFcIiPjSLDn3EL15IJygNPiHORgU1_OOAqWjiDU5Y)


## File structure

After having set up the project, the file structure would look like:

    app/ -> Anything specific to the app goes here
    app/assets/ -> Anything here is copied over to top-level directory as-is.
    app/assets/index.html -> The entry point index page
    app/common/ -> By convention anything that's shared across controllers
    app/application.coffee -> The top-level ApplicationController
    app/application.spec.coffee -> The spec for ApplicationController
    app/index.coffee -> The main entry point, where module definition takes place
    bower_compoennts/ -> Downloaded Bower components
    etc/changelog.tpl -> The template for building CHANGELOG.md
    etc/karma.conf.coffee -> The Karma configuration file
    node_modules/ -> downloaded NPM modules
    public/ -> The built code lives here
    bower.json -> Bower dependency declaration
    Gruntfile.coffee -> Gruntfile configuration
    LICENSE -> Pretty self-explanatory
    package.json -> NPM dependency declaration
    README.md -> This document


## Features

* [compass](http://compass-style.org/): configure Compass by defining
  `$GEM_HOME` on your command-line or in `config.coffee`. Check
  [sass-brunch](https://github.com/brunch/sass-brunch#options) for more info
* [Docker](http://jbt.github.io/docker/): generate documentation on build. Note
  that Docker only recognizes JSDoc declaration when it's in a block-style
  comment (i.e. `/* ... */`)


## Conventions and configuration

### Supported file types

Because ng-brunch doesn't try to handle the assembly process itself, it
supports anything found in the powerful ecosystem of Brunch! By default this
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

* Script files are compiled into one JavaScript file, `lib/code.js`
* Test files in JavaScript/CoffeeScript (`*.spec.js` and `*.spec.coffee`) are
  compiled into the file `lib/spec.js`
* Style files are compiled into one CSS file `lib/style.css`
* Markup files are compiled into one template-containing JavaScript file
  `lib/templates.js`

### Package management

Because developing in Angular.js requires many external libraries, package
management should be automated using [Bower](http://bower.io/). Follow these
steps:

1. Find the package you want by running `bower search <package-name>`
2. `bower install --save <package-name>`
3. That's it! :D

### App file structure

There is no convention here. Scripts, styles, and markups are compiled to
`public/`. Anything under `assets/` is treated as assets and are transferred
as-is to the top-level directory under `public/`.

Source maps of the compiled files are available in development mode.
