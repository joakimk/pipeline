require "spec_helper"
require "build_presenter"
require "ostruct"
require "build_mapping"

stub_constant :Build, OpenStruct

describe BuildPresenter, "#list" do
  it "returns builds" do
    builds = [
      Build.new(name: "tests"),
      Build.new(name: "deploy"),
    ]

    revision = double(:revision, builds: builds, build_mappings: [])
    presenter = BuildPresenter.new(revision)

    expect(presenter.list.map(&:name)).to eq([ "tests", "deploy" ])
  end

  it "keeps all the data" do
    builds = [
      Build.new(name: "tests", status: "building", status_url: "http://example.com"),
    ]

    revision = double(:revision, builds: builds, build_mappings: [])
    presenter = BuildPresenter.new(revision)

    expect(presenter.list.first.status_url).to include("example.com")
  end

  it "maps build names when mappings is available" do
    builds = [
      Build.new(name: "foo_tests"),
      Build.new(name: "foo_deploy"),
    ]
    build_mappings = [ BuildMapping.new("foo_tests", "tests") ]

    revision = double(:revision, builds: builds, build_mappings: build_mappings)
    presenter = BuildPresenter.new(revision)

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

    revision = double(:revision, builds: builds, build_mappings: build_mappings)
    presenter = BuildPresenter.new(revision)

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

    revision = double(:revision, builds: builds, build_mappings: build_mappings)
    presenter = BuildPresenter.new(revision)

    expect(presenter.list.map(&:name)).to eq([ "tests", "staging" ])
    expect(presenter.list.map(&:status)).to eq([ "building", "pending" ])
  end

  it "marks a build as 'fixed' if it was 'failed' and a newer build is 'successful'" do
    builds1 = [
      Build.new(name: "tests", status: "failed"),
    ]

    builds2 = [
      Build.new(name: "tests", status: "successful"),
    ]

    revision2 = double(:revision, builds: builds2)
    revision1 = double(:revision, builds: builds1, build_mappings: [], newer_revisions: [ revision2 ])

    presenter = BuildPresenter.new(revision1)
    expect(presenter.list.map(&:name)).to eq([ "tests" ])
    expect(presenter.list.map(&:status)).to eq([ "fixed" ])
  end
end
