class ChangeBuilds < ActiveRecord::Migration
  def up
    rename_column :builds, :step, :step_name
    add_column :builds, :project_name, :string

    AR::Build.reset_column_information
    AR::Build.order('id ASC').each do |build|
      build.update_attribute :project_name, AR::Project.find(build.project_id).name
    end

    remove_column :builds, :project_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
