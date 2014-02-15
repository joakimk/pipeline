class Project < ActiveRecord::Base
  attr_accessible :name, :github_url, :build_pattern, :repository

  has_many :revisions
  after_initialize :set_name

  validates :name, presence: true, format: /\A[a-z0-9_]+\z/

  def self.all_sorted_by_name
    order("name ASC")
  end

  def self.find_or_create_for_repository(repository)
    where(repository: repository).first_or_create!
  end

  private

  def set_name
    return unless repository
    self.name ||= repository.split("/").last.split(".").first
  end
end
