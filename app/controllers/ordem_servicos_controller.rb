class OrdemServicosController < ApplicationController
  before_action :set_ordem_servico, only: [ :show, :edit, :update, :adicionar_servico, :destroy, 
                                            :pagamento, :finalizar, :cancelar]

  # GET /ordem_servicos
  # GET /ordem_servicos.json
  def index
    if params[:type_search].present? and params[:find_by].present?
      type_search  = params[:type_search]
      num          = params[:find_by].gsub(/[^0-9]/,'').to_i
      cond = case type_search
        when '2' then { id: num }
        when '1' then "numero like '#{num}'"
        else { id: 0 }
      end
      @ordem_servicos = OrdemServico.includes(:servicos, :cliente).where(cond).order(id: :desc).paginate(page: params[:page])
      flash[:error] = t(:not_found, name: "Ordem de Serviços") if @ordem_servicos.blank?
    else
      @ordem_servicos = OrdemServico.includes(:servicos, :cliente).order(id: :desc).paginate(page: params[:page])
    end
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
    @ordem_servico.destroy
    @ordem_servico.ordem_servicos_servicos.destroy_all
    respond_to do |format|
      format.html { redirect_to ordem_servicos_path, notice: t(:destroy, name: 'Ordem de Serviço') }
      format.json { head :no_content }
    end
  end

  def destroy_oss
    oss = OSS.find(params[:id])
    @ordem_servico = oss.ordem_servico
    oss.destroy

    @ordem_servico.valor = @ordem_servico.ordem_servicos_servicos.pluck(:valor).sum.to_f
    @ordem_servico.save
    respond_to do |format|
      format.html { redirect_to @ordem_servico, notice: t(:updated, name: 'Ordem de Serviço') }
      format.json { head :no_content }
    end
  end


  def adicionar_servico
    if request.post? 
      servico = Servico.where(id: params[:servico_id]).first
      funcionario = Usuario.find(params[:funcionario_id]) 
      valor   = params[:valor].gsub('.','').gsub(',','.').to_f
      # parametros do new
      parametros = {  ordem_servico_id: @ordem_servico.id, 
                      servico_id: servico.try(:id), 
                      valor: valor, 
                      comissao: servico.percentual || funcionario.percentual, 
                      funcionario_id: params[:funcionario_id] 
                    }

      oss = OSS.new(parametros)
      if oss.save
        @ordem_servico.valor = @ordem_servico.ordem_servicos_servicos.pluck(:valor).sum.to_f
        @ordem_servico.save
        redirect_to @ordem_servico, notice: t(:updated, name: "Ordem de Serviço")
        return
      else
        redirect_to @ordem_servico, flash: { error: oss.errors.full_messages.join(' ') }
        return
      end
    end
    redirect_to @ordem_servico, flash: { error: "Não foi possível cadastrar serviço."}
  end

  def finalizar
    @ordem_servico.finalizar!
    redirect_to @ordem_servico, notice: t(:updated, name: "Ordem de Serviço")
  end

  def cancelar
    @ordem_servico.cancelar!
    redirect_to @ordem_servico, notice: t(:updated, name: "Ordem de Serviço")
  end  

  def pagamento
    @conta_corrente = ContaCorrente.new(ordem_servico_id: @ordem_servico.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ordem_servico
      @ordem_servico = OrdemServico.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ordem_servico_params
      params.require(:ordem_servico).permit(:cliente_id, :numero, :data)
    end
end
