require 'repositories/base'

describe Repository::Base do
  subject { described_class }
  implements_role :repository_backend

  it "is a singleton" do
    Repository::Base.instance.should == Repository::Base.instance
  end
end
