module ApplicationHelper
  def menu_item(name)
    MenuItem.new(name, @active_menu_item_name)
  end
end
