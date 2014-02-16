require "spec_helper"
require "revision_presenter"
require "ostruct"
require "build_mapping"

stub_class :Build, OpenStruct

describe RevisionPresenter, "#name" do
  it "is the first 6 characters" do
    revision = double(name: "00677457465544877dc2293f724009caa9da03a4")
    presenter = RevisionPresenter.new(revision)
    expect(presenter.name).to eq("006774")
  end
end

describe RevisionPresenter, "#builds" do
  it "returns builds" do
    build1 = Build.new(name: "tests")
    build2 = Build.new(name: "deploy")
    revision = double(builds: [ build1, build2 ], build_mappings: [])
    presenter = RevisionPresenter.new(revision)
    expect(presenter.builds.map(&:name)).to eq([ "tests", "deploy" ])
  end

  it "maps build names when mappings is available" do
    build1 = Build.new(name: "foo_tests")
    build2 = Build.new(name: "foo_deploy")
    build_mappings = [ BuildMapping.new("foo_tests", "tests") ]
    revision = double(builds: [ build1, build2 ], build_mappings: build_mappings)
    presenter = RevisionPresenter.new(revision)
    expect(presenter.builds.map(&:name)).to eq([ "tests", "foo_deploy" ])
  end

  it "sorts the builds based on mappings" do
    build1 = Build.new(name: "foo_deploy_production")
    build2 = Build.new(name: "foo_tests")
    build3 = Build.new(name: "foo_deploy_staging")
    build_mappings = [
      BuildMapping.new("foo_tests", "tests"),
      BuildMapping.new("foo_deploy_staging", "staging")
    ]
    revision = double(builds: [ build1, build2, build3 ], build_mappings: build_mappings)
    presenter = RevisionPresenter.new(revision)
    expect(presenter.builds.map(&:name)).to eq([ "tests", "staging", "foo_deploy_production" ])
  end

  it "fills out with blank build results until they turn up" do
    build1 = Build.new(name: "foo_tests", status: "building")
    build_mappings = [
      BuildMapping.new("foo_tests", "tests"),
      BuildMapping.new("foo_deploy_staging", "staging")
    ]
    revision = double(builds: [ build1 ], build_mappings: build_mappings)
    presenter = RevisionPresenter.new(revision)
    expect(presenter.builds.map(&:name)).to eq([ "tests", "staging" ])
    expect(presenter.builds.map(&:status)).to eq([ "building", "pending" ])
  end
end
