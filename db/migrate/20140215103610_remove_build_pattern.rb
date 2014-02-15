class RemoveBuildPattern < ActiveRecord::Migration
  def up
    remove_column :projects, :build_pattern
  end

  def down
  end
end
