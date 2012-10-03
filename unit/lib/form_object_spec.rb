require 'spec_helper'
require 'form_object'

class Filter
  include FormObject
  attribute :from, Date, default: Proc.new { Date.yesterday }
  attribute :number, Integer
end

describe FormObject, "persisted?" do
  subject { Filter.new }
  it { should_not be_persisted }
end

describe FormObject do
  it "can handle data from a form" do
    filter = Filter.new(from: "2012-01-15")
    filter.from.should be_kind_of(Date)
    filter.from.should == Date.parse("2012-01-15")
  end

  it "defaults" do
    filter = Filter.new
    filter.from.should == Date.yesterday
  end

  it "defaults when it cant parse a value" do
    filter = Filter.new(from: "2012-01-55")
    filter.from.should == Date.yesterday
  end

  it "returns nil when it cant parse the value and there is no default" do
    filter = Filter.new(number: "2012-01-55")
    filter.number.should be_nil
  end

  it "returns nil when there is no default" do
    filter = Filter.new
    filter.number.should be_nil
  end
end
