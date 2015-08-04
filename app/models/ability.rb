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
      # and caixa.created_at.to_date == Date.today
      can :admin, ContaCorrente
      can :pagamento, OrdemServico, status: 2
      can :lancar_pagamento, ContaCorrente
    end
    can :destroy, ContaCorrente

    can :admin, OrdemServico
    can :finalizar, OrdemServico, status: 1
    can [:adicionar_servico, :destroy_oss], OrdemServico
    can :destroy, OrdemServico do |o|; o.valor.to_f < 1; end
    #cannot [:edit, :update], ContaCorrente do |c|; c.ordem_servico_id ; end

    can [:new, :create], :registrations
    can [:editar_permissoes, :atualizar_permissoes], Usuario


    
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
