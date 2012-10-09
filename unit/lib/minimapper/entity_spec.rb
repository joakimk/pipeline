describe Minimapper::Entity do
  it "handles base attributes" do
    base = described_class.new
    base.id = 5
    base.id.should == 5

    time = Time.now
    base.created_at = time
    base.created_at.should == time

    base.updated_at = time
    base.updated_at.should == time
  end
end

describe Minimapper::Entity, "attributes" do
  it "returns the attributes" do
    base = described_class.new(id: 5)
    time = Time.now
    base.created_at = time
    base.attributes.should == { id: 5, created_at: time }
  end
end
