class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_usuario!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_dates
  
  # Requere Authorize CanCan ( model/ability.rb )
  authorize_resource unless: :no_check_authorized?

  # Rescue AccessDenied for CanCan ( model/ability.rb )
  #   call accesso_negado method
  rescue_from CanCan::AccessDenied do |exception|
    acesso_negado
  end
  
  # Alternative method for controllers ignored by no_check_authorized?
  def authorize_ability(resource)
    acesso_negado if cannot? action_name.to_sym, resource
  end

  # Redirecto to root_url with flash error message
  def acesso_negado
    redirect_to root_url, flash: { error: t(:access_denied) }
    return
  end

  def current_ability
    @current_ability ||= Ability.new(current_usuario)
  end

  protected
    #   Protected
    # Add current_usuario in versions inserts (paper_trail)
    def info_for_paper_trail
      if usuario_signed_in?
        { user_last_changed_id: current_usuario.id }
      end
    end

    #   Protected
    # Override method in devise user (forms -> create, edit_account)
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:entidade_id, :entidade_type, :email, :password, :password_confirmation, :nome, :celular, :telefone, :roles => []) }
      if action_name == 'update_account'
        devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:custo_mensal, :nome, :email, :celular, :telefone, :roles => []) } 
      end
    end

  private
    #   Private
    # CanCan: Ignore controllers without model
    def no_check_authorized?
      ['sessions'].include? controller_name
    end

    # Validar Datas do Array
    def check_dates
      campos = [:data_ini, :data_fim]

      campos.each do |c|
        if params[c].present?
          begin
            Date.parse(params[c])
          rescue
            redirect_to :back, flash: { error: t(:invalid_query) }
            return
          end
        end
      end
    end

   #require "#{Rails.root}/lib/get_data.rb"
=begin
   # Deixa "cliente_sessao" acessivel há todo o codigo
   attr_accessor :cliente_sessao
   # Define com qual cliente o usuario irá trabalhar
   def setar_cliente
      if current_usuario
         # mondrian? = verifica se o usuario pertence a entidade id = 1 ('Mondrian')
         if !current_usuario.mondrian? 
            self.cliente_sessao = current_usuario.cliente 
            #session['cliente_id'] = current_usuario.entidade_id
         elsif current_usuario.mondrian? and !session['cliente_id'].nil? and !session['cliente_id'].blank? 
            self.cliente_sessao = Cliente.find(session['cliente_id'])
         end
         begin
            if self.cliente_sessao.nil? and controller_name != 'usuarios' and controller_name != "devise"
               flash[:notice] = "Selecione o Cliente que deseja trabalhar"
               redirect_to selecionar_usuarios_path
               return
            end
         rescue => e
            render :text => e.to_s
         end
      else
         self.cliente_sessao = nil
      end
   end
=end
end
