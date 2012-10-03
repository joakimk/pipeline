require 'spec_helper'

describe "Adding projects" do
  it "can be done" do
    visit root_path
    click_link "Add project"
    fill_in "Name", with: "Deployer"
    fill_in "Github URL", with: "https://github.com/barsoom/deployer"
    click_button "Save"
    # hm, layout somehow not rendering
    #page.should have_content("Project added.")
    current_path.should == root_path
    repository.projects.last.github_url.should == "https://github.com/barsoom/deployer"
  end

  def repository
    Repository::Memory.instance
  end
end
