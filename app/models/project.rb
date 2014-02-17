class Project < ActiveRecord::Base
  has_many :revisions, dependent: :destroy
  after_initialize :set_name

  validates :name, presence: true

  def self.all_sorted
    order("position ASC, name ASC")
  end

  def self.find_or_create_for_repository(repository)
    where(repository: repository).first_or_create!
  end

  def latest_revisions(limit = 10)
    revisions.order('id desc').limit(limit)
  end

  def github_wiki_url
    if github_url
      "#{github_url}/wiki"
    else
      nil
    end
  end

  def github_url
    if repository.to_s.include?("github.com")
      match = repository.match(/github.com:(.*?)\./)
      github_path = match && match[1]
      "https://github.com/#{github_path}"
    else
      nil
    end
  end

  private

  def set_name
    return unless repository
    self.name ||= repository.split("/").last.split(".").first
  end
end
