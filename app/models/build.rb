class Build < ActiveRecord::Base
  attr_accessible :name, :revision, :status

  validates :name, :revision, :status, presence: true
  validates :revision, format: /^[a-z0-9]{40}$/

  def self.find_known_by(attributes)
    where(
      name:     attributes[:name],
      revision: attributes[:revision]
    ).first
  end
end
