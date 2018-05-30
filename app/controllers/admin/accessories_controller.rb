class Admin::AccessoriesController < ApplicationController
  def new
    @accessory = Item.new
  end
end
