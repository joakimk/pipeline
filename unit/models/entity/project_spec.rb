require 'entity/project'

describe Entity::Project do
  it "requires a name" do
    described_class.new.should have(1).error_on(:name)
    described_class.new(name: "Deployer").should have(0).error_on(:name)
  end
end
