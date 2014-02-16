require "spec_helper"
require "revision_presenter"

describe RevisionPresenter, "#name" do
  it "is the first 6 characters" do
    revision = double(name: "00677457465544877dc2293f724009caa9da03a4")
    presenter = RevisionPresenter.new(revision)
    expect(presenter.name).to eq("006774")
  end
end
