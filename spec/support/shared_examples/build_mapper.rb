shared_examples :build_mapper do

  Given(:build_mapper) { App.repository.builds }
  Given(:build)        { @build }

  When do
    App.repository = Minimapper::Repository.build(builds: described_class.new)
    @build = FactoryGirl.create(:build, project_name: "deployer", step_name: "build_assets", revision: "440f78f6de0c71e073707d9435db89f8e5390a59")
  end

  describe "find_known_by" do
    context "with a matching build" do
      Given(:entity) {  @entity }
      When { @entity = build_mapper.find_known_by(project_name: 'deployer', step_name: 'build_assets', revision: '440f78f6de0c71e073707d9435db89f8e5390a59')  }

      Then { entity.id.should == build.id }
      And { entity.should be_kind_of(Minimapper::Entity) }
    end

    context "with a non-matching build" do
      Given(:entity) { @entity }
      When { @entity = build_mapper.find_known_by(project_name: 'deployer', step_name: 'build_assets', revision: '0000000000000000000000000000000000000000') }
      Then { entity.should be_nil }
    end
  end
end
