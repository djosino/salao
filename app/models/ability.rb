class Ability
  include CanCan::Ability
  
  def initialize(usuario)
    alias_action :read, :new, :create, :edit, :update, to: :admin
    alias_action :read, :new, :create, :edit, :update, :destroy, to: :crud   
     
    @user = usuario || Usuario.new
    
    cannot :all, :all
    
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
    can :admin, [Cliente, Servico, Produto, Usuario, TipoServico]
    can :read, [Caixa, ContaCorrente, OrdemServico]

    can [:new, :create], Caixa do |c|; Caixa.abertos.count == 0; end
    can :fechar,         Caixa do |c|; c.status == 1; end

    caixa = Caixa.last
    if caixa and caixa.funcionario_id = @user.id and caixa.status == 1
      can :admin, [ContaCorrente, OrdemServico]
      can [:adicionar_servico, :cancelar, :destroy], OrdemServico, status: 1
      can :pagamento, OrdemServico, status: 2
      
      can [:finalizar, :cancelar], OrdemServico, status: 1
      can :lancar_pagamento, ContaCorrente
    end

    can [:new, :create], :registrations
    
    can  :lock,         Usuario, locked_at: nil
    can  :unlock,       Usuario do |u|; !u.locked_at.nil? ;  end
    can  :lock_unlock,  Usuario
    can [:edit_account, :update_account], :registrations

  end

  def gerente
  end

  def atendente
  end
end
