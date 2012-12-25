class MakeProjectsNameNotNull < ActiveRecord::Migration
  def up
    change_column :projects, :name, :string, null: false
  end

  def down
    change_column :projects, :name, :string
  end
end
