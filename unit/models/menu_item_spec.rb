require 'menu_item'

describe MenuItem, "haml_object_ref" do
  it "depends if menu item name and current menu item match" do
    MenuItem.new(:a, :a).haml_object_ref.should == 'active'
    MenuItem.new(:a, :b).haml_object_ref.should == ''
  end
end

describe MenuItem, "id" do
  it "should be nil" do
    MenuItem.new(:a, :b).id.should be_nil
  end
end
