module Kernel
  alias :oldold :require

  def require(*opts)
    t = Time.now
    ret = oldold(*opts)
    if Time.now - t > 0.1
      p [ opts, Time.now - t ]
    end
    ret
  end
end
silence_warnings do
  require 'ruby-prof'
  result = RubyProf.profile do
  require "virtus"
  end
  printer = RubyProf::GraphHtmlPrinter.new(result)
  f = File.open("output.html", 'wb')
  printer.print(f, :min_percent=>0)
  printer.print(f)
  f.close
end

module FormObject
  include Virtus

  module ClassMethods
    def attribute(name, type, opts = {})
      super(name, type, opts)
      define_method(name) do
        data = super()
        if data.is_a?(type)
          data
        elsif opts[:default]
          opts[:default].call
        else
          nil
        end
      end
    end
  end

  def self.included(descendant)
    super
    descendant.extend FormObject::ClassMethods

    # To make it work in forms
    descendant.extend ActiveModel::Naming
    descendant.send(:include, ActiveModel::Validations)
    descendant.send(:include, ActiveModel::Conversion)
  end

  def persisted?; false; end
end
