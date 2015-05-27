class ServicosController < ApplicationController
  before_action :set_servico, only: [:show, :edit, :update, :destroy]

  # GET /servicos
  # GET /servicos.json
  def index
    if params[:type_search].present? and params[:find_by].present?
      type_search  = params[:type_search]
      num          = params[:find_by].gsub(/[^0-9]/,'').to_i
      cond = case type_search
        when '1' then { tipo_servico_id:   num }
        else { id: 0 }
      end
      @servicos = Servico.where(cond).paginate(page: params[:page])
      flash[:error] = t(:not_found, name: "Serviços") if @servicos.blank?
    else
      @servicos = Servico.all.paginate(page: params[:page])
    end
  end

  # GET /servicos/1
  # GET /servicos/1.json
  def show
  end

  # GET /servicos/new
  def new
    @servico = Servico.new
  end

  # GET /servicos/1/edit
  def edit
  end

  # POST /servicos
  # POST /servicos.json
  def create
    @servico = Servico.new(servico_params)

    respond_to do |format|
      if @servico.save
        format.html { redirect_to servicos_path, notice: t(:created, name: 'Serviço') }
        format.json { render action: 'show', status: :created, location: @servico }
      else
        format.html { render action: 'new' }
        format.json { render json: @servico.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /servicos/1
  # PATCH/PUT /servicos/1.json
  def update
    respond_to do |format|
      if @servico.update(servico_params)
        format.html { redirect_to servicos_path, notice: t(:updated, name: 'Serviço') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @servico.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /servicos/1
  # DELETE /servicos/1.json
  def destroy
    @servico.destroy
    respond_to do |format|
      format.html { redirect_to servicos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_servico
      if params[:servico].present? and params[:servico][:valor].present?
        params[:servico][:valor] = params[:servico][:valor].gsub('.', '').gsub(',', '.')
      end
      @servico = Servico.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def servico_params
      params.require(:servico).permit(:descricao, :percentual, :valor, :tipo_servico_id)
    end
end
