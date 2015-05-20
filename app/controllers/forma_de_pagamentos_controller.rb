class FormaDePagamentosController < ApplicationController
  before_action :set_forma_de_pagamento, only: [:show, :edit, :update, :destroy]

  # GET /forma_de_pagamentos
  # GET /forma_de_pagamentos.json
  def index
    @forma_de_pagamentos = FormaDePagamento.all
  end

  # GET /forma_de_pagamentos/1
  # GET /forma_de_pagamentos/1.json
  def show
  end

  # GET /forma_de_pagamentos/new
  def new
    @forma_de_pagamento = FormaDePagamento.new
  end

  # GET /forma_de_pagamentos/1/edit
  def edit
  end

  # POST /forma_de_pagamentos
  # POST /forma_de_pagamentos.json
  def create
    @forma_de_pagamento = FormaDePagamento.new(forma_de_pagamento_params)

    respond_to do |format|
      if @forma_de_pagamento.save
        format.html { redirect_to @forma_de_pagamento, notice: t(:created, name: 'Forma de Pagamento') }
        format.json { render action: 'show', status: :created, location: @forma_de_pagamento }
      else
        format.html { render action: 'new' }
        format.json { render json: @forma_de_pagamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forma_de_pagamentos/1
  # PATCH/PUT /forma_de_pagamentos/1.json
  def update
    respond_to do |format|
      if @forma_de_pagamento.update(forma_de_pagamento_params)
        format.html { redirect_to @forma_de_pagamento, notice: t(:updated, name: 'Forma de Pagamento') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @forma_de_pagamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forma_de_pagamentos/1
  # DELETE /forma_de_pagamentos/1.json
  def destroy
    @forma_de_pagamento.destroy
    respond_to do |format|
      format.html { redirect_to forma_de_pagamentos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forma_de_pagamento
      @forma_de_pagamento = FormaDePagamento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def forma_de_pagamento_params
      params.require(:forma_de_pagamento).permit(:descricao)
    end
end
