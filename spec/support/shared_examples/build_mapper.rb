shared_examples :build_mapper do
  before do
    @build = FactoryGirl.create(:build, name: "deployer_tests", revision: "440f78f6de0c71e073707d9435db89f8e5390a59")
  end

  let(:build) { @build }

  describe "find_known_by" do
    it "finds a build that match on project step and revision" do
      entity = Build.find_known_by(name: 'deployer_tests', revision: '440f78f6de0c71e073707d9435db89f8e5390a59')
      entity.id.should == build.id
      entity.should be_kind_of(Minimapper::Entity)
    end

    it "does not find builds that don't match" do
      Build.find_known_by(name: 'deployer', revision: '0000000000000000000000000000000000000000').should be_nil
    end
  end
end
