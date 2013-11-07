# Worry-free AngularJS Development Stack <br/>[![Dependency Status](https://david-dm.org/kenhkan/ng-brunch.png)](https://david-dm.org/kenhkan/ng-brunch) [![Stories in Ready](https://badge.waffle.io/kenhkan/ng-brunch.png)](http://waffle.io/kenhkan/ng-brunch)

You should be able to develop AngularJS without having to set anything up. This
is the only AngularJS development stack you will ever need!


## Motivation

For AngularJS development,
[angular-seed](https://github.com/angular/angular-seed) is a great starting
point. [ngBoilerplate](https://github.com/ngbp/ng-boilerplate) is a fantastic
improvement over angular-seed. Though you still need to install a bunch of
dependencies and tinker with the Gruntfile unless you follow the ngBoilerplate
way completely.

Rather than handling everything as a monolithic development stack, ng-brunch
offloads the assembly workflow to [Brunch](http://brunch.io/). You need
additional language support? Check out the [Brunch plugins
page](https://github.com/brunch/brunch/wiki/Plugins) and you're set.


## Installation

1. Get Grunt: `npm install -g grunt`
2. Get this repo: `git clone https://github.com/kenhkan/ng-brunch.git`
3. Get NPM deps: `npm install`


## Usage

Easy as 1-2-3-4-5:

1. Open up `index.jade` and edit the `$PROCESS_ENV` variables. In the future
   these will be populated using environment variables. See [app
   settings](#app-settings) for more info.
2. Replace `$APP_NAME` with your app name. This will be automated
   in a setup script in the future.
3. Set the environment variable `APP_NAME` to your app's name
4. Run `grunt` to get Karma running, watching for file changes, and a Harp
   server running in the background
5. Open `localhost:3333` in the newly Karma-opened browser to view your app

### `grunt`

Development mode:

* Start watching for file changes
* Start up Karma
* Spin up a local webserver on `localhost:3333`

### `grunt build`

Production mode: build the app in production mode (minified and uglified)

### `grunt clean`

This resets the project to its pristine state.

### `grunt continuous`

Continuous mode: for testing on Travis, Jenkins, etc

### `grunt changelog`

See [changelog building](https://github.com/btford/grunt-conventional-changelog)

### `grunt bump`

See [version bumping](https://github.com/vojtajina/grunt-bump)


## File structure

After having set up the project, the file structure would look like:

    app/ -> Anything specific to the app goes here
    app/assets/ -> Anything here is copied over to top-level directory as-is
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


## Conventions and configuration

### Technologies

Because ng-brunch doesn't try to handle the assembly process itself, it
supports anything found in the powerful ecosystem of Brunch! By default this
repo supports:

* JavaScript/CoffeeScript
* CSS/Stylus
* HTML/Jade

But adding your favorite technologies are as easy as running `npm install
<brunch-plugin>`! Visit the [plugin
directory](https://github.com/brunch/brunch/wiki/Plugins) to hunt for your gems!

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

### Environment variables

[process-env-brunch](https://github.com/mikeedwards/process-env-brunch) is used
to scan through all compiled files for `$PROCESS_ENV_<name-here>` and take the
value from `process.env[<name-here>]` as a replacement.

### App settings

Open up `app/404.jade` and update the following to your app's settings:

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
