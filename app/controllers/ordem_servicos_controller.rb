class OrdemServicosController < ApplicationController
  before_action :set_ordem_servico, only: [:show, :edit, :update, :destroy, :adicionar_servico, :finalizar, :cancelar]

  # GET /ordem_servicos
  # GET /ordem_servicos.json
  def index
    @ordem_servicos = OrdemServico.includes(:servicos, :cliente).paginate(page: params[:page])
  end

  # GET /ordem_servicos/1
  # GET /ordem_servicos/1.json
  def show
  end

  # GET /ordem_servicos/new
  def new
    @ordem_servico = OrdemServico.new
  end

  # GET /ordem_servicos/1/edit
  def edit
  end

  # POST /ordem_servicos
  # POST /ordem_servicos.json
  def create
    @ordem_servico = OrdemServico.new(ordem_servico_params)
    @ordem_servico.usuario_id = current_usuario.id
    respond_to do |format|
      if @ordem_servico.save
        format.html { redirect_to @ordem_servico, notice: t(:created, name: 'Ordem de Serviços') }
        format.json { render action: 'show', status: :created, location: @ordem_servico }
      else
        format.html { render action: 'new' }
        format.json { render json: @ordem_servico.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ordem_servicos/1
  # PATCH/PUT /ordem_servicos/1.json
  def update
    respond_to do |format|
      if @ordem_servico.update(ordem_servico_params)
        format.html { redirect_to @ordem_servico, notice: t(:updated, name: 'Ordem de Serviços') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ordem_servico.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ordem_servicos/1
  # DELETE /ordem_servicos/1.json
  def destroy
    @ordem_servico.remover_servico(params[:servico_id])

    respond_to do |format|
      format.html { redirect_to @ordem_servico, notice: t(:updated, 'Ordem de Serviço') }
      format.json { head :no_content }
    end
  end

  def adicionar_servico
    if params[:servico_id].present?
      servico = Servico.find(params[:servico_id])
      @ordem_servico.servicos << servico
      redirect_to @ordem_servico, notice: t(:updated, name: "Ordem de Serviço")
      return
    end
    redirect_to @ordem_servico
  end

  def finalizar
    @ordem_servico.finalizar!
    redirect_to @ordem_servico, notice: t(:updated, name: "Ordem de Serviço")
  end

  def cancelar
    @ordem_servico.cancelar!
    redirect_to @ordem_servico, notice: t(:updated, name: "Ordem de Serviço")
  end  



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ordem_servico
      @ordem_servico = OrdemServico.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ordem_servico_params
      params.require(:ordem_servico).permit(:cliente_id, :valor)
    end
end
