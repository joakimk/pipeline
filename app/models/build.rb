class Build < ActiveRecord::Base
  attr_accessible :name, :revision, :status, :status_url

  validates :name, :status, presence: true

  belongs_to :revision
end
