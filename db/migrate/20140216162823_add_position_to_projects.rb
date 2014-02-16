class AddPositionToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :position, :integer, default: 0
  end
end
