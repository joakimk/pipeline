class RemoveGithubUrlFromProjects < ActiveRecord::Migration
  def up
    remove_column :projects, :github_url
  end

  def down
  end
end
