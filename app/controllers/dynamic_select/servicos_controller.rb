module DynamicSelect
  class ServicosController < ApplicationController
    respond_to :json
    skip_authorize_resource
    def index
      @servico   = Servico.where(id: params[:servico_id]).collect{|s| {name: s.valor.to_f.real_contabil, id: s.id, column: 'name', textfield: true} }
      @servico ||= [{name: '0.00', id: 0, column: 'name', textfield: true}]   if @servico.blank?
      respond_with(@servico)
    end
  end
end
