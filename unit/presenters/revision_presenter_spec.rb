require "spec_helper"
require "revision_presenter"

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
