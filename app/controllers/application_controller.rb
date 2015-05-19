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
    # Override method in devise user (forms -> create, edit_account)
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:nome, :name, :email, :password, :password_confirmation, :percentual, :telefone2, :telefone, :roles => []) }
      if action_name == 'update_account'
        devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:nome, :email, :name, :percentual, :telefone2, :telefone, :roles => []) } 
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
end
