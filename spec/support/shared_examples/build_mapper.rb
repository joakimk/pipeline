shared_examples :build_mapper do
  # expects repository
  before do
    App.repository = repository
    @build = FactoryGirl.create(:build, project_name: "deployer", step_name: "build_assets", revision: "456")
  end

  let(:build) { @build }

  describe "find_known_by" do
    it "finds a build that match on project step and revision" do
      entity = repository.builds.find_known_by(project_name: 'deployer', step_name: 'build_assets', revision: '456')
      entity.id.should == build.id
      entity.should be_kind_of(Minimapper::Entity)
    end

    it "does not find builds that don't match" do
      repository.builds.find_known_by(project_name: 'deployer', step_name: 'build_assets', revision: '789').should be_nil
    end
  end
end
