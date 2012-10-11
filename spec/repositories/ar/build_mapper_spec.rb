require 'spec_helper'

describe Repository::AR::BuildMapper, :pg do
  let(:repository) { Repositories::AR }
  include_examples :build_mapper
end
