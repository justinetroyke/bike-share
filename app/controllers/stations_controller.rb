class StationsController < ApplicationController
  def show
    @station = Station.find_by(slug: params[:slug])
  end
end
