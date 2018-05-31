class Admin::AccessoriesController < ApplicationController
  def new
    @accessory = Accessory.new
  end

  def create
    @accessory = Accessory.new(accessory_params)
    if @accessory.save
      redirect_to accessory_path(@accessory)
    else
      flash[:notice] = 'Sorry! That title has already been taken. Please choose another'
      # require 'pry';binding.pry
      render :new
    end
  end

  private

  def accessory_params
    params.require(:accessory).permit(:title, :description, :price)
  end
end
