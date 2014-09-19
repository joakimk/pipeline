require "spec_helper"
require "build_lock"

describe BuildLock, "take" do
  let(:redis) { double(:redis) }

  let(:expected_key) { "build_lock_for_e7f7aba1bf1f93975cc69900bff9a3ae9cdb34cb_foo_tests" }

  before do
    allow(redis).to receive(:setnx)
    allow(redis).to receive(:get)
    allow(redis).to receive(:expire)
  end

  it "takes a lock" do
    expect(redis).to receive(:setnx).with(expected_key, "rev")
    BuildLock.new("repo-url", "foo_tests", redis).take("rev")
  end

  it "returns the currently locked revision" do
    allow(redis).to receive(:get).with(expected_key).and_return("rev_a")
    locked_by_revision = BuildLock.new("repo-url", "foo_tests", redis).take("rev_a")
    expect(locked_by_revision).to eq("rev_a")
  end

  it "sets a timeout for the lock" do
    expect(redis).to receive(:expire).with(expected_key, 60 * 30)
    BuildLock.new("repo-url", "foo_tests", redis).take("rev_a")
  end
end
