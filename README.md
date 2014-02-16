[![Build Status](https://secure.travis-ci.org/joakimk/deployer.png)](http://travis-ci.org/joakimk/deployer)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/joakimk/deployer)

## Work in progress

This will be an app to manage deploys. I plan to import some of the internal deployment tools from [barsoom](http://barsoom.se) into this app.

## Running the tests

You need postgres installed.

    script/bootstrap

    rake              # all tests
    rake spec:unit    # unit tests
    rake spec         # integrated tests

## Download production data

    rake app:reset
