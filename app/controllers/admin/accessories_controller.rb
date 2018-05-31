class Admin::AccessoriesController < ApplicationController
  def new
    @accessory = Accessory.new
  end

  def create
    accessory = Accessory.create!(accessory_params)
    redirect_to accessory_path(accessory)
  end

  private

  def accessory_params
    params.require(:accessory).permit(:title, :description, :price)
  end
end
