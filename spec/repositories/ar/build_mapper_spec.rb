require 'spec_helper'

describe AR::BuildMapper do
  let(:repository) { Repositories::AR }
  include_examples :build_mapper
end
