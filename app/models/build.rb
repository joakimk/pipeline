class Build < ActiveRecord::Base
  attr_accessible :name, :revision, :status

  validates :name, :status, presence: true

  belongs_to :revision
end
