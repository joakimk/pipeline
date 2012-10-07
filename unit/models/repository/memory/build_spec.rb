require 'repository/memory/build'
require 'entity/build'

describe Repository::Memory::Build, "find_known_by" do
  let(:repository) { Repository::Memory.instance }
  let(:build) { Entity::Build.new(project: 'github', step: 'build_assets', revision: '456', status: 'building') }

  after do
    repository.builds.delete_all
  end

  it "finds a build that match on project step and revision" do
    repository.builds.add(build)
    repository.builds.find_known_by(project: 'github', step: 'build_assets', revision: '456').id.should == build.id
  end

  it "does not find builds that don't match" do
    repository.builds.add(build)
    repository.builds.find_known_by(project: 'github', step: 'build_assets', revision: '789').should be_nil
  end
end
