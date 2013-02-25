class CreateThroughRepositoryStrategy
  def result(evaluation)
    mapper_name = evaluation.object.class.name.underscore.pluralize
    Repo.send(mapper_name).create(evaluation.object)
    evaluation.object
  end
end

FactoryGirl.register_strategy(:create, CreateThroughRepositoryStrategy)
