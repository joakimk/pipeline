silence_warnings do
  require "virtus"
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
