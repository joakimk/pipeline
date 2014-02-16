require "spec_helper"
require "revision_presenter"
require "ostruct"
require "build_mapping"

describe RevisionPresenter, "#name" do
  it "is the first 6 characters" do
    revision = double(name: "00677457465544877dc2293f724009caa9da03a4")
    presenter = RevisionPresenter.new(revision)
    expect(presenter.name).to eq("006774")
  end

  # todo:
  # - reproduce that we've doing in the view
  # - order them in the order of the mappings
  # - show gray boxes for mappings that exist where
  #   we don't have any build info yet
  # - show "fixed" status if a later revision fixes
  #   and earlier one
end

describe RevisionPresenter, "#builds" do
  it "returns builds" do
    build1 = double(name: "tests")
    build2 = double(name: "deploy")
    revision = double(builds: [ build1, build2 ], build_mappings: [])
    presenter = RevisionPresenter.new(revision)
    expect(presenter.builds.map(&:name)).to eq([ "tests", "deploy" ])
  end

  it "maps build names when mappings is available" do
    build1 = OpenStruct.new(name: "foo_tests")
    build2 = OpenStruct.new(name: "foo_deploy")
    build_mappings = [ BuildMapping.new("foo_tests", "tests") ]
    revision = double(builds: [ build1, build2 ], build_mappings: build_mappings)
    presenter = RevisionPresenter.new(revision)
    expect(presenter.builds.map(&:name)).to eq([ "tests", "foo_deploy" ])
  end
end
