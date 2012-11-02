require 'build'

describe Build, "project_id=" do
  it "converts string to integer" do
    Build.new(project_id: '20').project_id.should == 20
  end
end
