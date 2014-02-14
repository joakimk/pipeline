class Project < ActiveRecord::Base
  attr_accessible :name, :github_url, :build_pattern

  validates :name, presence: true, format: /\A[a-z0-9_]+\z/

  def self.all_sorted_by_name
    order("name ASC")
  end
end
