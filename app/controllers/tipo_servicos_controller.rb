class TipoServicosController < ApplicationController
  before_action :set_tipo_servico, only: [:show, :edit, :update, :destroy]

  # GET /tipo_servicos
  # GET /tipo_servicos.json
  def index
    @tipo_servicos = TipoServico.all.paginate(page: params[:page])
  end

  # GET /tipo_servicos/1
  # GET /tipo_servicos/1.json
  def show
  end

  # GET /tipo_servicos/new
  def new
    @tipo_servico = TipoServico.new
  end

  # GET /tipo_servicos/1/edit
  def edit
  end

  # POST /tipo_servicos
  # POST /tipo_servicos.json
  def create
    @tipo_servico = TipoServico.new(tipo_servico_params)

    respond_to do |format|
      if @tipo_servico.save
        format.html { redirect_to tipo_servicos_path, notice: t(:created, name: 'Tipo de Serviço') }
        format.json { render action: 'show', status: :created, location: @tipo_servico }
      else
        format.html { render action: 'new' }
        format.json { render json: @tipo_servico.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipo_servicos/1
  # PATCH/PUT /tipo_servicos/1.json
  def update
    respond_to do |format|
      if @tipo_servico.update(tipo_servico_params)
        format.html { redirect_to tipo_servicos_path, notice: t(:updated, name: 'Tipo de Serviço') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tipo_servico.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_servicos/1
  # DELETE /tipo_servicos/1.json
  def destroy
    @tipo_servico.destroy
    respond_to do |format|
      format.html { redirect_to tipo_servicos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_servico
      @tipo_servico = TipoServico.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipo_servico_params
      params.require(:tipo_servico).permit(:descricao, :ativo)
    end
end
