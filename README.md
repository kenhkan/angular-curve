# Setup-free AngularJS Development Skeleton <br/>[![Dependency Status](https://david-dm.org/kenhkan/ng-brunch.png)](https://david-dm.org/kenhkan/ng-brunch) [![NPM version](https://badge.fury.io/js/ng-brunch.png)](http://badge.fury.io/js/ng-brunch) [![Stories in Ready](https://badge.waffle.io/kenhkan/ng-brunch.png)](http://waffle.io/kenhkan/ng-brunch)

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

1. I assume you have [Node.js/NPM](http://nodejs.org/)
2. You need [Grunt](http://gruntjs.com/): `npm install -g grunt`
3. Clone this repo: `git clone https://github.com/kenhkan/ng-brunch.git`
4. Get NPM and Bower deps: `npm install`


## Usage

1. Open up `app/index.jade` and edit the `$PROCESS_ENV` variables. In the
   future these will be populated using environment variables. See [app
   settings](#app-settings) for more info.
2. ~~Set the environment variable `APP_NAME` to your app's name~~ Replace
   `$APP_NAME` with your app name. This will be automated in a setup script in the
   future.
4. Run `grunt` to get Karma running, watching for file changes, and a server
   running in the background
5. Open `localhost:3333` in the newly Karma-opened browser to view your app

### `grunt`

Development mode:

* Start watching for file changes
* Spin up a local webserver on `localhost:3333`
* Start up Karma at `localhost:9876`

### `grunt develop`

Purely development mode. Like development mode but without test server (i.e.
Karma)

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


## File structure

After having set up the project, the file structure would look like:

    app/ -> Anything specific to the app goes here
    app/assets/ -> Anything here is copied over to top-level directory as-is.
    app/common/ -> By convention anything that's shared across controllers
    app/application.coffee -> The top-level ApplicationController
    app/application.spec.coffee -> The spec for ApplicationController
    app/index.coffee -> The main entry point, where module definition takes place
    app/index.jade -> The "index" page
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

* [autoprefixer](https://github.com/ai/autoprefixer): included to ease
  cross-browser CSS headaches


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

### Environment variables

[process-env-brunch](https://github.com/mikeedwards/process-env-brunch) is used
to scan through all compiled files for `$PROCESS_ENV_<varName>` and take the
value from `process.env.<varName>` as replacement.

### App settings

Open up `app/index.jade` and update the following to your app's settings:

* APP_NAME: the name of the app that will be passed to AngularJS
* TWITTER_HANDLE: ditto
* CREATOR_HANDLE: the creator's Twitter handle
* CARD_SUMMARY: a summary for Twitter card
* CARD_TITLE: ditto
* CARD_DESCRIPTION: ditto
* CARD_IMAGE: the URL pointing to an image for the card
* CARD_URL: the URL pointing to any page

Aside from these variables, remember to update your AngularJS dependencies in
`app/index.coffee`.
