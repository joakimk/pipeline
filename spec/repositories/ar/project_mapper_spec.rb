require 'spec_helper'
require 'ar/project_mapper'

describe AR::ProjectMapper do
  let(:repository) { Repositories::AR }
  include_examples :project_mapper
end
