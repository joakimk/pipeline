![Build status](https://secure.travis-ci.org/joakimk/deployer.png) | [builds](https://travis-ci.org/#!/joakimk/deployer/builds)

## Work in progress

This will be an app to manage deploys. I plan to import some of the internal deployment tools from [barsoom](http://barsoom.se) into this app.

## The code

I'm trying to find a good adaptation for [The Clean Architecture](http://blog.8thlight.com/uncle-bob/2012/08/13/the-clean-architecture.html) for larger rails apps, so I'm using this as a playground. Because of this, there might be things in this app that are architectural overkill for such a small app.

## Structure

* Entity classes (domain models): [app/models/entity](https://github.com/joakimk/deployer/tree/master/app/models/entity)
* Use cases (actions you can take with the app): [app/use_cases](https://github.com/joakimk/deployer/tree/master/app/use_cases)
* Memory storage: [app/models/repository/memory](https://github.com/joakimk/deployer/tree/master/app/models/repository/memory)
* Postgres storage: [app/models/repository/pg](https://github.com/joakimk/deployer/tree/master/app/models/repository/pg)
* Persistence code is tested with [shared examples](https://github.com/joakimk/deployer/blob/master/spec/support/shared_examples/repository.rb)

## Fast tests

With this setup you can [test validations like you usually do](https://github.com/joakimk/deployer/blob/master/unit/models/entity/project_spec.rb), and still have very fast tests.

    Finished in 0.67609 seconds
    1000 examples, 0 failures

## Running the tests

You need postgres installed.

    script/bootstrap

    rake
    rake spec:unit # only unit tests
