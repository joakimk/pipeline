class RemoveProjectAndAddProjectIdToBuilds < ActiveRecord::Migration
  def change
    remove_column :builds, :project
    add_column :builds, :project_id, :integer
  end
end
