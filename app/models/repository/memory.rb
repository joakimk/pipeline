require 'singleton'

class Repository::Memory
  include Singleton

  def projects
    @projects ||= Project.new
  end

  class Base
    def initialize
      @list = []
    end

    def add(entity)
      @list << entity
    end

    def last
      @list.last
    end

    def all
      @list.dup
    end
  end

  class Project < Base
    include Repository::Common::Project
  end
end
