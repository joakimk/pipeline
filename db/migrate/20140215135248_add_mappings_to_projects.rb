class AddMappingsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :mappings, :text
  end
end
