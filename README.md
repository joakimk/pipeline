[![Build Status](https://secure.travis-ci.org/joakimk/deployer.png)](http://travis-ci.org/joakimk/deployer)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/joakimk/deployer)

## About

This is a tool for viewing CI build status from multiple CI servers and projects. It is based on the internal tools we have been using at [barsoom](http://barsoom.se).

It can be deployed to heroku but there are no instructions yet.

The tool used to report build status isn't part of this repo yet (but you can probably build your own quite quickly, see API docs below).

## How it looks

![how it looks](http://cl.ly/image/3t021A0n2d25/Screen%20Shot%202014-02-16%20at%201.10.25%20PM.png)

Each commit shows up as it's own line, the newest at the top. Within each line boxes are shown for the different builds run on that revision.

The names links to the `status_url` passed in when reporting builds. At barsoom we pass in a link to the jenkins build result console. This way we can easily get to any build result of any recent revision.

## API

The api token is set with the `API_TOKEN` environment variable.

Build status are reported to `/api/build_statuses` as a POST with the following attributes:

* *name*: the name of the build (e.g. foo_tests or foo_deploy)
* *repository*: the repository path (e.g. git@github...)
* *revision*: the git revision
* *status_url*: the url to link to for showing build results
* *status*: can be `building`, `successful` or `failed`

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

* Be able to sort build results
* Add heroku deploy instructions
* Add build reporting script
  - possibly built in go so that it is simple to install, no deps on ruby or similar
* Make the UI nicer
* Possibly make the UI auto-updating. Maybe client side MVC.
* Possibly make it possible to view one project at a time, or the latest results from all projects in a compact view.
* Tell the world about it :)
* Explore using it do manage continous deployment pipelines better and simpler than can be done with jenkins plugins.
