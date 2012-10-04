require 'informal'

module Entity
  class Base
    include Informal::Model
    attr_accessor :id
  end
end
