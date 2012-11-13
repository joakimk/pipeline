require 'spec_helper'

describe do
  let(:repository) { App.repository }

  describe "Adding projects" do
    it "can be done" do
      when_adding_a_project_with name: "Name", github_url: "https://github.com/barsoom/deployer"
      then_there_should_be_a_project_with github_url: "https://github.com/barsoom/deployer"
    end

    it "reports errors", :web_only do
      when_attempting_to_add_an_invalid_project
      page.should have_content("Name can't be blank")
      then_there_should_be_no_projects
    end
  end

  describe "Removing projects" do
    it "can be done" do
      project = Project.new(name: "TheApp")
      repository.projects.create(project)
      visit root_path

      within("#project_#{project.id}") do
        click_link "Remove"
      end

      current_path.should == root_path
      page.should have_content("Project removed.")
      repository.projects.all.should be_empty
    end
  end

  describe "Editing projects" do
    it "when successful" do
      project = Project.new(name: "TheApp")
      repository.projects.create(project)
      visit root_path

      within("#project_#{project.id}") do
        click_link "Edit"
      end

      fill_in "Github URL", with: "https://github.com/barsoom/the_app"
      click_button "Save"

      current_path.should == root_path
      page.should have_content("Project updated.")
      repository.projects.find(project.id).github_url.should == "https://github.com/barsoom/the_app"
    end

    it "when there are validation errors" do
      project = Project.new(name: "TheApp")
      repository.projects.create(project)
      visit edit_project_path(project)

      fill_in "Name", with: ""
      click_button "Save"

      page.should have_content("Name can't be blank")
      current_path.should == project_path(project)
      repository.projects.find(project.id).name.should == "TheApp"
    end
  end
end
