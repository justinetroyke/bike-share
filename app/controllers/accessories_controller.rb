class AccessoriesController < ApplicationController
  def index
    @items = Item.all
  end
end
