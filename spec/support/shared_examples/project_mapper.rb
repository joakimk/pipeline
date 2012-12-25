shared_examples :project_mapper do
  # expects repository
  let(:projects_mapper) { repository.projects }
  let(:project) { FactoryGirl.create(:entity_project, name: "deployer") }

  describe "all_sorted_by_name" do
    it "returns all projects projects alphabetically" do
      projects_mapper.create FactoryGirl.create(:entity_project, name: "beta")
      projects_mapper.create FactoryGirl.create(:entity_project, name: "alpha")

      projects = repository.projects.all_sorted_by_name
      projects.map(&:name).should == [ "alpha", "beta" ]
      projects.first.should be_kind_of(Minimapper::Entity)
    end
  end
end
