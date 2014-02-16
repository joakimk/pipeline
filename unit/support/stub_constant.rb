# Missing constant stubbing inspired by "Objects on Rails"
# http://avdi.org/devblog/2011/11/15/early-access-beta-of-objects-on-rails-now-available-2/

# Usage:
# require 'support/stub_constant'
# stub_class 'ActiveRecord::Base'
# stub_module 'Rails'
# stub_class 'Savon::SOAP::Fault', Exception # stub with superclass

def stub_module(full_name)
  stub_constant(full_name)
end

def stub_class(full_name, superclass = Object)
  klass = Class.new(superclass)
  stub_constant(full_name, klass)
end

def stub_constant(full_name, constant = Module)
  full_name.to_s.split(/::/).inject(Object) do |context, name|
    begin
      context.const_get(name)
    rescue NameError
      context.const_set(name, constant)
    end
  end
end
