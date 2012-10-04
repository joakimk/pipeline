require 'repository_backend'

describe RepositoryBackend do
  subject { described_class }
  implements_role :repository_backend

  it "is a singleton" do
    RepositoryBackend.instance.should == RepositoryBackend.instance
  end
end
