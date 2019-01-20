class Api::V1::FormationsController < Api::V1::BaseController
  before_action :set_formation, only: [ :show, :update, :destroy ]

  def index
    if params.nil?
      @formations = Formation.all
    else
      search_params = params.permit(:id, :nom, :date_debut)
      @formations = Formation.where(search_params)
    end

    unless params.permit(:more_than_zero_place)[:more_than_zero_place].nil?
      more_than_zero = params.permit(:more_than_zero_place)[:more_than_zero_place]
      if more_than_zero == "true"
          @formations = @formations.where.not(nombre_place_restante: nil).where(nombre_place_restante: 1..Float::INFINITY)
      end
    end
  end

  def show
  end

  def update
    if @formation.update(formation_params)
      render :show
    else
      render json: @formation.errors, status: :unprocessable_entity
    end
  end

  def create
    @formation = Formation.new(formation_params)
    if @formation.save
      render :show, status: :created
    else
      render json: @formation.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @formation.destroy
    head :no_content
    # No need to create a `destroy.json.jbuilder` view
  end

  private

  def set_formation
    @formation = Formation.find(params[:id])
  end

  def formation_params
    params.require(:formation).permit(:nom, :programme, :date_debut, :date_fin, :nombre_place_total, :nombre_place_restante)
  end
end
