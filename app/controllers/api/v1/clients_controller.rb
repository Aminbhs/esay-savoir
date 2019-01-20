class Api::V1::ClientsController < Api::V1::BaseController
  before_action :set_client, only: [ :show, :update, :destroy ]

  def index
    unless params.nil?
      search_params = params.permit(:nom, :id, :prenom, :email)
    end
    @clients = Client.where(search_params)
  end

  def show
  end

  def update
    if @client.update(client_params)
      render :show
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      render :show, status: :created
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @client.destroy
    head :no_content
    # No need to create a `destroy.json.jbuilder` view
  end

  def get_clients_by_formation
    params_formation = params.permit(:formation_id, :date_debut)

    if params_formation[:formation_id] && params_formation[:date_debut]
        date_debut = params_formation[:date_debut]
        formation_id = params_formation[:formation_id]

      @formations = Formation.where(id: formation_id, date_debut: date_debut )
    elsif params_formation[:formation_id]
      formation_id = params_formation[:formation_id]
      @formations = Formation.where(id: formation_id)
    elsif params_formation[:date_debut]
      date_debut = params_formation[:date_debut]
      @formations = Formation.where(date_debut: date_debut)
    else
      render json: {error: "Not found"}, status: :unprocessable_entity
    end
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:nom, :prenom, :num_rue, :rue, :codepostal, :ville, :telephone, :email)
  end
end
