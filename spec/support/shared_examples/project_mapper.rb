shared_examples :project_mapper do
  before { App.repository = Minimapper::Repository.build(projects: described_class.new) }

  describe "all_sorted_by_name" do
    it "returns all projects projects alphabetically" do
      FactoryGirl.create(:project, name: "alpha")
      FactoryGirl.create(:project, name: "beta")

      projects = App.repository.projects.all_sorted_by_name
      projects.map(&:name).should == [ "alpha", "beta" ]
      projects.first.should be_kind_of(Minimapper::Entity)
    end
  end
end
