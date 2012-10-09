![Build status](https://secure.travis-ci.org/joakimk/deployer.png) | [builds](https://travis-ci.org/#!/joakimk/deployer/builds)

## Work in progress

This will be an app to manage deploys. I plan to import some of the internal deployment tools from [barsoom](http://barsoom.se) into this app.

## About the code

I'm trying to find a good adaptation of [The Clean Architecture](http://blog.8thlight.com/uncle-bob/2012/08/13/the-clean-architecture.html) for larger rails apps, so I'm using this as a playground. Because of this, there might be things in this app that are architectural overkill for such a small app.

## Directory structure

* Models: [app/models](https://github.com/joakimk/deployer/tree/master/app/models)
* Services (actions you can take with the app): [app/services](https://github.com/joakimk/deployer/tree/master/app/services)
* Persistence
  - Tested with [shared examples](https://github.com/joakimk/deployer/blob/master/spec/support/shared_examples/mapper.rb)
  - Memory storage: [app/repositories/memory](https://github.com/joakimk/deployer/tree/master/app/repositories/memory)
  - ActiveRecord storage: [app/repositories/ar](https://github.com/joakimk/deployer/tree/master/app/repositories/ar)
* Testing
  - Unit tests (does not load rails and each test is about 1ms): [unit/](https://github.com/joakimk/deployer/blob/master/unit)
  - Integrated tests (everything else): [spec/](https://github.com/joakimk/deployer/blob/master/spec)

# Architecture

    # Rails ##          # The ruby app #########################
    Controller -------> Service -> Model -> Repository(::Memory)
    Mailer                 |                   |
    BG job                 |                   |
                           |                   |
    View <- Presenter <----|                Repository::AR
    # Rails #########                       # Rails ######
            ^^^^^^^^^
            Note: Presenters and code in lib/ can usually be made
                  independent of rails too.

## Fast tests

With this setup you can test [validations](https://github.com/joakimk/deployer/blob/master/unit/models/project_spec.rb) and [persistence](https://github.com/joakimk/deployer/blob/master/unit/services/build_status_service_spec.rb) like you usually do, and still have very fast tests.

    Finished in 0.67609 seconds
    1000 examples, 0 failures

## Running the tests

You need postgres installed.

    script/bootstrap

    rake
    rake spec:unit # only unit tests
