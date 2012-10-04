class CreateProjects < ActiveRecord::Migration
  def up
    create_table :projects do |t|
      t.timestamps
      t.string :name
      t.string :github_url
    end
  end

  def down
    drop_table :projects
  end
end
