require 'spec_helper'

describe AR::BuildMapper, :pg do
  let(:repository) { Repositories::AR }
  include_examples :build_mapper
end
