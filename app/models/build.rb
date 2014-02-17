class Build < ActiveRecord::Base
  validates :name, :status, presence: true

  belongs_to :revision
end
