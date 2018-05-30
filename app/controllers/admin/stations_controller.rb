class Admin::StationsController < Admin::BaseController
  def edit
    @station = Station.find(params[:id])
  end

  def update
    @station = Station.find(params[:id])
    @station.update(station_params)
    if @station.save
      flash[:notice]
      redirect_to station_path @station
    else
      redirect_to edit_admin_station_path @station
    end
  end

  def destroy
    @station = Station.find(params[:id])
    @station.destroy
    redirect_to stations_path
  end

  private

  def station_params
    params.require(:station).permit(:name, :dock_count, :city, :installation_date)
  end
end