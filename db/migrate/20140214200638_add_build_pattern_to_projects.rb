class AddBuildPatternToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :build_pattern, :string
  end
end
