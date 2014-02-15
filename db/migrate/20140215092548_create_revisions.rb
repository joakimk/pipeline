class CreateRevisions < ActiveRecord::Migration
  def change
    create_table :revisions do |t|
      t.string :name, null: false
      t.integer :project_id, null: false

      t.timestamps
    end
  end
end
