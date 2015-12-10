require 'menu_item'

describe MenuItem, "class" do
  it "depends if menu item name and current menu item match" do
    item = MenuItem.new(:a, :a)
    expect(item.class).to eq("active")

    item = MenuItem.new(:a, :b)
    expect(item.class).to eq("")
  end
end
