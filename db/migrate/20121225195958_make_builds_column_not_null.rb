class MakeBuildsColumnNotNull < ActiveRecord::Migration
  def up
    change_column :builds, :project_name, :string, null: false
    change_column :builds, :step_name, :string, null: false
    change_column :builds, :revision, :string, null: false
    change_column :builds, :status, :string, null: false
  end

  def down
    change_column :builds, :project_name, :string
    change_column :builds, :step_name, :string
    change_column :builds, :revision, :string
    change_column :builds, :status, :string
  end
end
