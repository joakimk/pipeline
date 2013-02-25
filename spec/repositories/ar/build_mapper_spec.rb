require 'spec_helper'

describe BuildMapper, :db do
  before do
    @build = FactoryGirl.create(:build, project_name: "deployer", step_name: "build_assets", revision: "440f78f6de0c71e073707d9435db89f8e5390a59")
  end

  let(:build_mapper) { App.repository.builds }
  let(:build) { @build }

  describe "find_known_by" do
    it "finds a build that match on project step and revision" do
      entity = build_mapper.find_known_by(project_name: 'deployer', step_name: 'build_assets', revision: '440f78f6de0c71e073707d9435db89f8e5390a59')
      entity.id.should == build.id
      entity.should be_kind_of(Minimapper::Entity)
    end

    it "does not find builds that don't match" do
      build_mapper.find_known_by(project_name: 'deployer', step_name: 'build_assets', revision: '0000000000000000000000000000000000000000').should be_nil
    end
  end
end
