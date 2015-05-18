class Ability
  include CanCan::Ability
  
  def initialize(usuario)
    alias_action :manage, to: :all
    alias_action :read, :new, :create, :edit, :update, :destroy, to: :crud   
     
    @user = usuario || Usuario.new
    
    can :all, :all
    
    if @user.id
      send(@user.entidade_type.downcase)
      @user.roles.each { |role| send(role) }
    end
    
    # TODO
    can :index,       Usuario
    can [:scan, :atualizar_hora, :ferramentas], Usuario
    can [:edit, :update], :registrations
  end
  
  def gerente_geral

  end

  def gerente_filial

  end

end
