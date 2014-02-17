[![Build Status](https://secure.travis-ci.org/joakimk/deployer.png)](http://travis-ci.org/joakimk/deployer)
[![Code Climate](https://codeclimate.com/github/joakimk/deployer.png)](https://codeclimate.com/github/joakimk/deployer)

## About

This is a tool for viewing CI build status from multiple CI servers and projects. It is based on the internal tools we have been using at [barsoom](http://barsoom.se).

It can be deployed to heroku but there are no instructions yet.

The tool used to report build status isn't part of this repo yet (but you can probably build your own quite quickly, see API docs below).

## How it looks

![how it looks](http://cl.ly/image/0r0D1C2P1I2v/Screen%20Shot%202014-02-17%20at%2013.01.15.png)

Each commit shows up as it's own line, the newest at the top. Within each line boxes are shown for the different builds run on that revision.

The build names are links to the `status_url` passed in when reporting builds. At barsoom we pass in a link to the jenkins build result console. This way we can easily get to any build result of any recent revision.

## API

The api token is set with the `API_TOKEN` environment variable.

Build status are reported to `/api/build_statuses` as a POST with the following attributes:

* *name*: The name of the build (e.g. foo_tests or foo_deploy). The app assumes that each build has a unique name. You use mappings configured for each project to display short names as in the screenshot.
* *repository*: The repository path (e.g. git@github...).
* *revision*: The git revision.
* *status_url*: The url to link to for showing build results.
* *status*: Current build status, can be `building`, `successful` or `failed`.

Normally the client would first post with the status of `building` and then either `successful` or `failed` after the build is done.

## Running the tests

You need postgres installed.

    script/bootstrap

    rake              # all tests
    rake spec:unit    # unit tests
    rake spec         # integrated tests

## Download production data

    rake app:reset

## TODO

V1:

* Require auth to access websockets
  - https://devcenter.heroku.com/articles/websocket-security
* Add build reporting script
  - possibly built in go so that it is simple to install, no deps on ruby or similar
* Add heroku deploy instructions, look at [gridlook](https://github.com/barsoom/gridlook#installation)
* Think of a better name for it?
* Upgrade rails and ruby. Require ruby 2.1? If so, change .travis.yml.
* Tell the world about it :)

Later:
* Be able to manually trigger builds in CI. Probably some kind of plugin-API.
* Possibly make it possible to view one project at a time, or the latest results from all projects in a compact view.
* Custom urls configurable for projects, possibly driven by custom data in build status?
* Show fixed status for builds when a later revision fixes a build [see `fixed_status` branch]
* Support for custom badges, etc. Like codeclimate.
* Explore using it do manage continous deployment pipelines better and simpler than can be done with jenkins plugins.
* Stats: averge build times, estimated time left, time from commit to deploy, average number of commits per deploy, ...
