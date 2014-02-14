require 'menu_item'

describe MenuItem, "class" do
  it "depends if menu item name and current menu item match" do
    MenuItem.new(:a, :a).class.should == 'active'
    MenuItem.new(:a, :b).class.should == ''
  end
end
