module Repository
  module Common
    CanNotUpdateEntityWithoutId = Class.new(StandardError)
    CanNotFindEntity            = Class.new(StandardError)
  end
end
