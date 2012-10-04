require 'form_object'

module Entity
  class Base
    include FormObject
    attribute :id, Integer
  end
end
