require 'spec_helper'

describe Repository::AR::BuildMapper, :pg do
  let(:repository) { Repository::AR.instance }
  include_examples :build_mapper
end
