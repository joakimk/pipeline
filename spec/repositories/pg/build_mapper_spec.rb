require 'spec_helper'

describe Repository::PG::BuildMapper, :pg do
  let(:repository) { Repository::PG.instance }
  include_examples :build_mapper
end
