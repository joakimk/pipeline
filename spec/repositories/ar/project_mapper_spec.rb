require 'spec_helper'
require 'ar/project_mapper'

describe AR::ProjectMapper, :db do
  include_examples :project_mapper
end
