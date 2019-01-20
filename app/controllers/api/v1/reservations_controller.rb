class Api::V1::ReservationsController < Api::V1::BaseController

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      render :show, status: :created
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  def delete_by_client_and_formation_id

    client = Client.find(delete_reservation_params[:client_id])
    formation = Formation.find(delete_reservation_params[:formation_id])

    @reservation = Reservation.find_by(client_id: client, formation_id: formation)
    if @reservation
      @reservation.destroy
    head :no_content
    # No need to create a `destroy.json.jbuilder` view
    else
      render json: {error: "Réservation not found"}, status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:client_id , :formation_id)
  end

  def delete_reservation_params
    params.permit(:client_id , :formation_id)
  end
end
