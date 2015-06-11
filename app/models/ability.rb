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
    can :index,         Usuario
    can [:ferramentas], Usuario
    can [:edit, :update],                 :registrations
    can [:edit_account, :update_account], :registrations
  end
  
  def administrador
    can :admin, [Cliente, Servico, Produto, OrdemServico, Usuario, ContaCorrente, TipoServico]
    can :index, Caixa
    can [:new, :create], Caixa do |c|; Caixa.abertos.count == 0; end
    can :fechar,         Caixa do |c|; Caixa.abertos.count == 1; end

    can [:adicionar_servico, :cancelar, :destroy], OrdemServico, status: 1
    can :pagamento, OrdemServico, status: 2
    
    can [:finalizar, :cancelar], OrdemServico, status: 1
    can [:new, :create], :registrations

    can  :lock,         Usuario, locked_at: nil
    can  :unlock,       Usuario do |u|; !u.locked_at.nil? ;  end
    can  :lock_unlock,  Usuario
    can [:edit_account, :update_account], :registrations

    can :lancar_pagamento, ContaCorrente
  end

  def gerente
  end

  def atendente
  end
end