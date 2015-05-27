module DynamicSelect
  class FormaDePagamentosController < ApplicationController
    respond_to :json
    skip_authorize_resource
    def index
      tipo_lancamento    = TipoLancamento.where(id: params[:tipo_lancamento_id]).last.forma_de_pagamentos
      @tipo_lancamento   = tipo_lancamento.collect{|c| { name: c.descricao, id: c.id, column: 'name'}}
      respond_with(@tipo_lancamento)
    end
  end
end
