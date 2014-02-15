class AddStatusUrlToBuilds < ActiveRecord::Migration
  def change
    add_column :builds, :status_url, :string
  end
end
