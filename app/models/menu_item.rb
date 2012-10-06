require 'ostruct'

class MenuItem
  def initialize(name, current)
    @active = (name == current)
  end

  def haml_object_ref
    @active ? 'active' : ''
  end

  def id
  end
end
