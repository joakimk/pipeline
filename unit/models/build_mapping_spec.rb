require "spec_helper"
require "build_mapping"

describe BuildMapping, ".build_list" do
  it "builds a list of mappings based on text input" do
    mappings = BuildMapping.build_list("foo_tests=tests\r\nfoo_deploy=deploy\r\n")
    expect(mappings.size).to eq(2)
    expect(mappings.map(&:from)).to eq([ "foo_tests", "foo_deploy" ])
    expect(mappings.map(&:to)).to eq([ "tests", "deploy" ])
  end
end
