require "spec_helper"
require "build_presenter"
require "ostruct"
require "build_mapping"
require "minimapper"
require "minimapper/entity"

# Behaves aproximatly like the model, don't want to load the entire app, or
# add in support for loading AR models right now. No need yet.
class Build
  include Minimapper::Entity
  attributes :name, :status, :status_url
end

describe BuildPresenter, "#list" do
  it "returns builds" do
    builds = [
      Build.new(name: "tests"),
      Build.new(name: "deploy"),
    ]

    presenter = BuildPresenter.new(builds, [])

    expect(presenter.list.map(&:name)).to eq([ "tests", "deploy" ])
  end

  it "keeps all the data" do
    builds = [
      Build.new(name: "tests", status: "building", status_url: "http://example.com"),
    ]

    presenter = BuildPresenter.new(builds, [])
    expect(presenter.list.first.status_url).to include("example.com")
  end

  it "maps build names when mappings is available" do
    builds = [
      Build.new(name: "foo_tests"),
      Build.new(name: "foo_deploy"),
    ]
    build_mappings = [ BuildMapping.new("foo_tests", "tests") ]

    presenter = BuildPresenter.new(builds, build_mappings)

    expect(presenter.list.map(&:name)).to eq([ "tests", "foo_deploy" ])
  end

  it "sorts the builds based on mappings" do
    builds = [
      Build.new(name: "foo_deploy_production"),
      Build.new(name: "foo_tests"),
      Build.new(name: "foo_deploy_staging"),
    ]
    build_mappings = [
      BuildMapping.new("foo_tests", "tests"),
      BuildMapping.new("foo_deploy_staging", "staging")
    ]

    presenter = BuildPresenter.new(builds, build_mappings)

    expect(presenter.list.map(&:name)).to eq([ "tests", "staging", "foo_deploy_production" ])
  end

  it "fills out with blank build results until they turn up" do
    builds = [
      Build.new(name: "foo_tests", status: "building")
    ]
    build_mappings = [
      BuildMapping.new("foo_tests", "tests"),
      BuildMapping.new("foo_deploy_staging", "staging")
    ]

    presenter = BuildPresenter.new(builds, build_mappings)

    expect(presenter.list.map(&:name)).to eq([ "tests", "staging" ])
    expect(presenter.list.map(&:status)).to eq([ "building", "pending" ])
  end
end
