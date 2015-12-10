require "spec_helper"

describe ProjectStatusSerializer do
  it "serializes the status of a project as a hash" do
    # Previous build
    update_with revision: "0000000000000000000000000000000000000000", name: "foo_tests", status: "successful", status_url: "url-for-rev-0"
    update_with revision: "0000000000000000000000000000000000000000", name: "foo_deploy", status: "successful", status_url: "url-for-rev-0"

    # Just started build
    update_with revision: "1111111111111111111111111111111111111111", name: "foo_tests", status: "building", status_url: "url-for-rev-1"

    # Set up build mappings (so that we can see pending statuses)
    project = Project.last
    project.mappings = [
      "foo_tests=tests",
      "foo_deploy=deploy",
    ].join("\r\n")

    # Check the current status
    hash = ProjectStatusSerializer.new(project).serialize
    expect(hash).to eq(
      project_name: "foo",
      latest_revisions: [
        {
          hash: "1111111111111111111111111111111111111111",
          short_name: "111111",
          builds: [
            {
              name: "tests",
              status: "building",
            },
            {
              name: "deploy",
              status: "pending",
            },
          ]
        },
        {
          hash: "0000000000000000000000000000000000000000",
          short_name: "000000",
          builds: [
            {
              name: "tests",
              status: "successful",
            },
            {
              name: "deploy",
              status: "successful",
            },
          ]
        }
      ]
    )
  end

  private

  def update_with(custom = {})
    attributes = {
      repository: "git@example.com:user/foo.git",
    }.merge(custom)

    UpdateBuildStatus.call(
      attributes[:name],
      attributes[:repository],
      attributes[:revision],
      attributes[:status],
      attributes[:status_url],
    )
  end
end
