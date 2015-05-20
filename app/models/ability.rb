class Ability
  include CanCan::Ability
  
  def initialize(usuario)
    alias_action :read, :new, :create, :edit, :update, to: :admin
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
    can :admin, Cliente
    can :admin, Servico
    can :admin, Produto
    can :admin, OrdemServico

    can [:finalizar, :cancelar], OrdemServico, status: 1
  end

  def gerente
  end

  def atendente
  end
end