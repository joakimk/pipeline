## Work in progress

This will be an app to manage deploys. I plan to import some of the internal deployment tools from [barsoom](http://barsoom.se) into this app.

## The code

I'm trying to find a good adaptation for [The Clean Architecture](http://blog.8thlight.com/uncle-bob/2012/08/13/the-clean-architecture.html) for larger rails apps, so I'm using this as a playground. Because of this, there might be things in this app that are architectural overkill for such a small app.

## Running the tests

You need postgres installed.

    script/bootstrap

    rake
    rake spec:unit # only unit tests