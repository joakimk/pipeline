require 'spec_helper'

describe "Projects", :db do
  let(:repository) { App.repository }

  describe "Adding projects" do
    it "can be done" do
      visit root_path
      page.find(".active").should have_content("Projects")
      click_link "Add project"
      page.find(".active").should have_content("Add project")
      fill_in "Name", with: "deployer"
      fill_in "Github URL", with: "https://github.com/barsoom/deployer"
      click_button "Save"
      page.should have_content("Project added.")
      current_path.should == root_path
        repository.projects.last.github_url.should == "https://github.com/barsoom/deployer"
    end

    it "reports errors" do
      visit root_path
      click_link "Add project"
      click_button "Save"
      page.should have_content("Name can't be blank")
      repository.projects.last.should be_nil
    end
  end

  describe "Removing projects" do
    it "can be done" do
      project = Project.new(name: "the_app")
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
      project = Project.new(name: "the_app")
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
      project = Project.new(name: "the_app")
      repository.projects.create(project)
      visit edit_project_path(project)

      fill_in "Name", with: ""
      click_button "Save"

      page.should have_content("Name can't be blank")
      current_path.should == project_path(project)
      repository.projects.find(project.id).name.should == "the_app"
    end
  end
end
