module SharedSteps
  def then_there_should_be_a_project_with(attributes)
    project = repository.projects.last
    attributes.each do |key, value|
      project.attributes[key].should == value
    end
  end

  def then_there_should_be_no_projects
    repository.projects.all.should be_empty
  end
end

module EndToEndSteps
  include SharedSteps

  def when_adding_a_project_with(opts = {})
    name       = opts[:name]
    github_url = opts[:github_url]

    visit root_path
    page.find(".active").should have_content("Projects")
    click_link "Add project"
    page.find(".active").should have_content("Add project")
    fill_in "Name", with: name
    fill_in "Github URL", with: github_url
    click_button "Save"
    page.should have_content("Project added.")
    current_path.should == root_path
  end

  def when_attempting_to_add_an_invalid_project
    visit root_path
    click_link "Add project"
    click_button "Save"
  end
end

module ApiSteps
  include SharedSteps

  def when_adding_a_project_with(opts = {})
    name       = opts[:name]
    github_url = opts[:github_url]

    project = Project.new(name: name, github_url: github_url)
    repository.projects.create(project)
  end
end
