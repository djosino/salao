module DynamicSelect
  class UsuariosController < ApplicationController
    respond_to :json
    skip_authorize_resource
    def index
      @usuario   = Usuario.where(id: params[:funcionario_id]).collect{|u| {name: u.percentual.to_i.to_s, id: u.id, column: 'name', textfield: true} }
      @usuario ||= [{name: '0,00', id: 0, column: 'name', textfield: true}]   if @usuario.blank?
      respond_with(@usuario)
    end
  end
end
