class Ability
  include CanCan::Ability
  
  def initialize(usuario)
    alias_action :manage, to: [:read, :new, :create, :edit, :update]
    alias_action :read, :new, :create, :edit, :update, :destroy, to: :crud   
     
    @user = usuario || Usuario.new
    
    can :all, :all
    
    if @user.id
      @user.roles.each { |role| send(role) }
    end
    
    # TODO
    can :index,       Usuario
    can [:ferramentas], Usuario
    can [:edit, :update], :registrations
  end
  
  def administrador
    can :manage, Cliente
    can :manage, Servico
    can :manage, Produto
    can :manage, OrdemServico
  end

  def gerente
  end

  def atendente
  end
end