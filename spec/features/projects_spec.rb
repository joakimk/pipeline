require 'spec_helper'

describe do
  describe "Removing projects" do
    it "can be done" do
      project = Project.new(name: "the_app")
      project.save!
      visit root_path

      within("#project_#{project.id}") do
        click_link "Remove"
      end

      current_path.should == root_path
      page.should have_content("Project removed.")
      Project.all.should be_empty
    end
  end

  describe "Editing projects" do
    it "when successful" do
      project = Project.new(name: "the_app")
      project.save!
      visit root_path

      within("#project_#{project.id}") do
        click_link "Edit"
      end

      fill_in "Github URL", with: "https://github.com/barsoom/the_app"
      click_button "Save"

      current_path.should == root_path
      page.should have_content("Project updated.")
      Project.find(project.id).github_url.should == "https://github.com/barsoom/the_app"
    end

    it "when there are validation errors" do
      project = Project.new(name: "the_app")
      project.save!
      visit edit_project_path(project)

      fill_in "Name", with: ""
      click_button "Save"

      page.should have_content("Name can't be blank")
      current_path.should == project_path(project)
      Project.find(project.id).name.should == "the_app"
    end
  end
end
