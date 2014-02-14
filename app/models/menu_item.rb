require 'ostruct'

class MenuItem
  def initialize(name, current)
    @active = (name == current)
  end

  def class
    @active ? 'active' : ''
  end
end
