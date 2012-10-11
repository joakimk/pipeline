module Minimapper
  class Repository
    def self.build(mappers)
      new(mappers)
    end

    def initialize(mappers)
      @mappers = mappers
      mappers.each do |name, instance|
        singleton = (class << self; self end)
        singleton.send(:define_method, name) do
          instance
        end
      end
    end

    def delete_all!
      mappers.each { |name, instance| instance.delete_all }
    end

    private

    attr_reader :mappers
  end
end
