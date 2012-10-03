require 'singleton'

class Repository::Memory
  include Singleton

  def projects
    @projects ||= Project.new
  end

  class Base
    def add(entity)
      @list ||= []
      @list << entity
    end

    def last
      @list.last
    end
  end

  class Project < Base
    include Repository::Common::Project
  end
end
