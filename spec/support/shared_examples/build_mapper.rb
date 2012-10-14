shared_examples :build_mapper do
  # expects repository
  let(:build) { Build.new(project: 'github', step: 'build_assets', revision: '456', status: 'building') }

  describe "find_known_by" do
    it "finds a build that match on project step and revision" do
      repository.builds.create(build)
      repository.builds.find_known_by(project: 'github', step: 'build_assets', revision: '456').id.should == build.id
    end

    it "does not find builds that don't match" do
      repository.builds.create(build)
      repository.builds.find_known_by(project: 'github', step: 'build_assets', revision: '789').should be_nil
    end
  end
end
