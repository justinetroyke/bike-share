class Admin::TripsController < Admin::BaseController

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:id])
    @trip.update(trip_params)
    if @trip.save
      flash[:notice]
      redirect_to trip_path @trip
    else
      redirect_to edit_admin_trip_path @trip
    end
  end

  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy
    redirect_to trips_path
  end

  private

  def trip_params
    params.require(:trip).permit(:bike_id, 
                                 :subscription_type, 
                                 :zip_code, 
                                 :bike_id,
                                 :start_station_id,
                                 :end_station_id,
                                 :start_date,
                                 :end_date)
  end

end