class Admin::AccessoriesController < ApplicationController
  before_action :set_accessory, only: [:edit, :update]
  def new
    @accessory = Accessory.new
  end

  def create
    @accessory = Accessory.new(accessory_params)
    if @accessory.save
      redirect_to accessory_path(@accessory)
    else
      if @accessory.errors.messages[:title].include?("has already been taken")
        flash[:notice] = 'Sorry! That title has already been taken. Please choose another.'
      elsif @accessory.errors.messages[:price].include?("must be greater than 0") || @accessory.errors.messages[:price].include?("is not a number")
        flash[:notice] = 'Please enter a valid decimal numeral value for your price. It must also be greater than zero.'
      else
        flash[:notice] = 'Whoops! Something has gone wrong. Please try again.'
      end
      render :new
    end
  end

  def index
    @accessories = Accessory.all
  end

  def edit
  end
  
  def update
    @accessory.update(accessory_params)
    redirect_to accessory_path(@accessory)
  end
  
  private

  def accessory_params
    params.require(:accessory).permit(:title, :description, :price)
  end

  def set_accessory
    @accessory = Accessory.find(params[:id])
  end
end
