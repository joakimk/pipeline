![Build status](https://secure.travis-ci.org/joakimk/deployer.png)

## Work in progress

This will be an app to manage deploys. I plan to import some of the internal deployment tools from [barsoom](http://barsoom.se) into this app.

## The code

I'm trying to find a good adaptation for [The Clean Architecture](http://blog.8thlight.com/uncle-bob/2012/08/13/the-clean-architecture.html) for larger rails apps, so I'm using this as a playground. Because of this, there might be things in this app that are architectural overkill for such a small app.

## Structure

* Entity classes (domain models): app/models/entity
* Use cases (actions you can take with the app): app/use_cases
* Memory storage: app/models/repository/memory
* Postgres storage: app/models/repository/pg

## Running the tests

You need postgres installed.

    script/bootstrap

    rake
    rake spec:unit # only unit tests
