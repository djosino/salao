class ContaCorrentesController < ApplicationController
  before_action :set_conta_corrente, only: [:show, :edit, :update, :destroy]

  # GET /conta_correntes
  # GET /conta_correntes.json
  def index
    cond = "classe_type = 'Cliente' and not (ordem_servico_id is not null and carteira is true)"
    inc  = [:ordem_servico, :classe,:tipo_lancamento,:forma_de_pagamento]
    if params[:data_ini].present? and params[:data_final].present?
      @conta_correntes = ContaCorrente.where(cond).where(["created_at::date between ? and ?", params[:data_ini].to_date, params[:data_final].to_date]).includes(inc).order(id: :desc).paginate(page: params[:page])
      flash[:error] = t(:not_found, name: "Conta Corrente") if @conta_correntes.blank?
    else
      @conta_correntes = ContaCorrente.where(cond).includes(inc).order(id: :desc).paginate(page: params[:page])
    end
    #@conta_correntes = ContaCorrente.all
    #if params[:data_ini].present?
    #  @clientes = Cliente.all
    #else
    #  @carteiras = Carteira.joins(:cliente).order("clientes.nome")
    #end
    #if params[:imprimir].present?
    #  render layout: 'print'
    #end
  end

  # GET /conta_correntes/1
  # GET /conta_correntes/1.json
  def show
  end

  # GET /conta_correntes/new
  def new
    @conta_corrente = ContaCorrente.new
  end

  # GET /conta_correntes/1/edit
  def edit
    @formas_de_pagamento = @conta_corrente.tipo_lancamento.forma_de_pagamentos
  end

  # POST /conta_correntes
  # POST /conta_correntes.json
  def create
    @conta_corrente = ContaCorrente.new(conta_corrente_params)
    @conta_corrente.data ||= Date.today
    if params[:selecione].present?
      if params[:selecione] == 'cliente'
        @conta_corrente.funcionario = nil
      else
        @conta_corrente.cliente     = nil
      end
    end
    respond_to do |format|
      if @conta_corrente.save
        format.html { redirect_to :back, notice: t(:created, name: 'Lançamento') }
        format.json { render action: 'show', status: :created, location: @conta_corrente }
      else
        format.html { render action: 'new' }
        format.json { render json: @conta_corrente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conta_correntes/1
  # PATCH/PUT /conta_correntes/1.json
  def update
    respond_to do |format|
      if @conta_corrente.update(conta_corrente_params)
        format.html { redirect_to conta_correntes_path, notice: t(:updated, name: 'Conta Corrente') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @conta_corrente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conta_correntes/1
  # DELETE /conta_correntes/1.json
  def destroy
    @conta_corrente.destroy
    respond_to do |format|
      format.html { redirect_to pagamento_ordem_servico_path(@conta_corrente.ordem_servico) }
      format.json { head :no_content }
    end
  end

  def lancar_pagamento
    @funcionarios = Usuario.where(id: params[:funcionarios]).order(:id)

    @funcionarios.each do |func|
      comissao        = conta_corrente = 0
      adiantamento    = ContaCorrente.where("forma_de_pagamento_id = 8 and created_at::date = ? and classe_type = 'Usuario' and classe_id = ?", params[:data].to_date, func.id).pluck(:valor).sum
      descontado      = []
      OSS.joins(:ordem_servico).where("created_at::date = ? and funcionario_id = ?", params[:data].to_date, func.id).each do |oss|
        desconto      = (descontado.include?(oss.id) ? 0 : 2)
        descontado   << oss.id
        comissao     += ((oss.valor - desconto) * (oss.comissao || func.comissao).to_f / 100)
      end
      if (comissao - adiantamento) > 0
        lancamento = ContaCorrente.new(tipo_lancamento_id: 2, classe_type: 'Usuario', classe_id: func.id, funcionario_id: func.id, valor: comissao - adiantamento, observacao: "Pagamento do dia #{l(Date.today)}", forma_de_pagamento_id: 1)
        if lancamento.save
          flash[:notice] = "Pagamentos realizados com sucesso"
        else
          render text: lancamento.errors.full_messages
          return
        end
      end
    end
    redirect_to extrato_por_funcionario_relatorios_path
  end

  def pagamento_debito
    @conta_corrente = ContaCorrente.new({cliente_id: params[:cliente_id], carteira: true, tipo_lancamento_id: 1})
    if request.post?
      @conta_corrente.assign_attributes(conta_corrente_params)
      @conta_corrente.data ||= Date.today
      respond_to do |format|
        if @conta_corrente.save
          format.html { redirect_to @conta_corrente.cliente, notice: t(:created, name: 'Pagamento') }
          format.json { head :no_content }
        else
          format.html { redirect_to pagamento_debitos_conta_correntes_path(cliente_id: @conta_corrente.cliente_id), flash: { error: @conta_corrente.errors.full_messages } }
          format.json { render json: @conta_corrente.errors, status: :unprocessable_entity }
        end
      end    
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conta_corrente
      @conta_corrente = ContaCorrente.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conta_corrente_params
      if params[:conta_corrente].present? and params[:conta_corrente][:valor].present?
        params[:conta_corrente][:valor] = params[:conta_corrente][:valor].gsub('.', '').gsub(',', '.')
      end
      params.require(:conta_corrente).permit(:cliente_id, :funcionario_id, :tipo_lancamento_id, :valor, :observacao, :forma_de_pagamento_id, :ordem_servico_id, :carteira, :data)
    end
end
