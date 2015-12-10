require 'spec_helper'

describe "Projects", type: :feature do
  describe "Removing projects" do
    it "can be done" do
      project = Project.new(name: "the_app")
      project.save!
      visit root_path

      within("#project_#{project.id}") do
        click_link "Edit"
      end

      click_link "Remove"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Project removed.")
      expect(Project.all).to be_empty
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

      fill_in "Name", with: "The app"
      click_button "Save"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Project updated.")
      expect(Project.find(project.id).name).to eq("The app")
    end

    it "when there are validation errors" do
      project = Project.new(name: "the_app")
      project.save!
      visit edit_project_path(project)

      fill_in "Name", with: ""
      click_button "Save"

      expect(page).to have_content("Name can't be blank")
      expect(current_path).to eq(project_path(project))
      expect(Project.find(project.id).name).to eq("the_app")
    end
  end
end
