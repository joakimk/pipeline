require "spec_helper"

describe Build do
  it "requires a name" do
    build = FactoryGirl.build(:build, name: nil)
    expect(build).not_to be_valid
  end

  it "requires a status" do
    build = FactoryGirl.build(:build, status: nil)
    expect(build).not_to be_valid
  end
end
