require "spec_helper"

describe Build do
  it "requires a name" do
    FactoryGirl.build(:build, name: nil).should_not be_valid
  end

  it "requires a status" do
    FactoryGirl.build(:build, status: nil).should_not be_valid
  end
end
