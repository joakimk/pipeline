module ApplicationHelper
  def menu_item_class(name)
    MenuItem.new(name, @active_menu_item_name).class
  end
end
