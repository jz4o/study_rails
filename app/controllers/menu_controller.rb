class MenuController < ApplicationController
  def index
    @menu_items = Menu.items
  end

  def show
    @menu_item = Menu.items[params[:index].to_i]
  end
end
