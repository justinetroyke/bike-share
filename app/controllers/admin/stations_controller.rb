class Admin::StationsController < Admin::BaseController

  def edit
    @station = Station.find(params[:id])
  end

  def update
    @station = Station.find(params[:id])
    if @station.update(station_params)
      flash[:success] = "#{@station.name} updated!"
      redirect_to station_path(@station.slug)
    else
      flash[:error] = "#{@station.name} not updated!"
      render :edit
    end
  end

  def destroy
    @station = Station.find(params[:id])
    name = @station.name
    @station.destroy
    flash[:notice] = "#{name} Deleted"
    redirect_to stations_path
  end

  private

  def station_params
    params.require(:station).permit(:name, :dock_count, :city, :installation_date)
  end
end
