class ModifyBuilds < ActiveRecord::Migration
  def up
    Build.delete_all
    add_column :builds, :revision_id, :integer
    remove_column :builds, :revision
  end

  def down
  end
end
