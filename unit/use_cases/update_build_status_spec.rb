require "update_build_status"
require "rspec-given"

describe UpdateBuildStatus do
  Given(:repository) { App.repository }
  Given(:update_build_status) { described_class }
  Given(:builds) { repository.builds.all }

  def update_with(custom = {})
    build_attributes = FactoryGirl.attributes_for(:build).merge(custom)
    update_build_status.run(repository, build_attributes)
  end

  context "when there are no previous builds" do
    When { update_with project_name: "deployer" }

    Then { builds.size.should == 1 }
    And { builds.first.project_name.should == "deployer" }
  end

  context "when there are previous builds" do
    When { update_with status: "building" }
    When { update_with status: "successful" }

    Then { builds.size.should == 1 }
    And { builds.first.status.should == "successful" }
  end

  context "when there are more than App.builds_to_keep builds" do
    Given(:revisions) { repository.builds.all.map(&:revision).to_s }

    When { App.stub(builds_to_keep: 2) }
    When { update_with revision: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" }
    When { update_with revision: "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb" }
    When { update_with revision: "cccccccccccccccccccccccccccccccccccccccc" }

    Then { revisions.should_not include("a") }
    And { revisions.should include("b") }
    And { revisions.should include("c") }
  end
end
