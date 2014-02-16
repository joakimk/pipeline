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
    build = Build.new(name: "tests")
    revision = double(builds: [ build ], build_mappings: [])
    presenter = RevisionPresenter.new(revision)
    expect(presenter.builds.map(&:name)).to eq([ "tests" ])
  end
end
