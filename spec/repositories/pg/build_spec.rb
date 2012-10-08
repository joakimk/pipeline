require 'spec_helper'

describe Repository::PG::Build, :pg do
  let(:repository) { Repository::PG.instance }
  include_examples :build_repository
end
