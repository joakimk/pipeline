class RenameBuildsProjectNameToNameAndRemoveStepName < ActiveRecord::Migration
  def change
    rename_column :builds, :project_name, :name
    remove_column :builds, :step_name
  end

  def down
  end
end
