module FactoryGirl
  def self.repository=(repository)
    @@repository = repository
  end

  def self.repository
    if defined?(@@repository)
      @@repository
    else
      raise "Factory.repository not set."
    end
  end
end

class CreateThroughRepositoryStrategy
  def result(evaluation)
    mapper_name = evaluation.object.class.name.underscore.pluralize
    FactoryGirl.repository.send(mapper_name).create(evaluation.object)
    evaluation.object
  end
end

FactoryGirl.register_strategy(:create, CreateThroughRepositoryStrategy)
