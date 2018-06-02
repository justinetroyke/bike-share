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

  def new
    @station = Station.new
  end

  def create
    @station = Station.new(station_params)
    if @station.save
      flash[:notice] = "#{@station.name} Station Created"
      redirect_to station_path(@station.slug)
    else
      flash[:error] = "Incorrect attributes entered"
      redirect_to new_admin_station_path
    end
  end

  private

  def station_params
    params.require(:station).permit(:name, :dock_count, :city, :installation_date)
  end
end
