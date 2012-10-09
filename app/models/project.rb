class Project < Minirepo::Entity
  attributes :name, :github_url

  validates :name, presence: true
end
