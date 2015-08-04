class ContaCorrente < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :funcionario, class_name: "Usuario", foreign_key: :funcionario_id
  belongs_to :tipo_lancamento
  belongs_to :forma_de_pagamento
  belongs_to :ordem_servico

  belongs_to :classe, :polymorphic => true 

  validates_presence_of :valor, :observacao, :tipo_lancamento, :forma_de_pagamento_id, :data
  validate :cliente_ou_funcionario
  after_save :set_carteira

  scope :clientes,     -> { where(classe_type: "Cliente") }
  scope :funcionarios, -> { where(classe_type: "Usuario") }
  scope :creditos,     -> { where(tipo_lancamento_id: 1).where("carteira is not true") }
  scope :debitos,      -> { where(tipo_lancamento_id: 2).where("carteira is not true") }
  scope :dia,          -> (data) { where("data::date = ?", data.to_date) }

  #before_save :criar_cc, on: :create

  def cliente_ou_funcionario
    #if self.cliente.nil? and self.funcionario.nil?
    #  errors.add(:base, 'Informe um Cliente ou Funcionario') 
    #  return false
    #end
    self.classe = self.cliente      if self.cliente
    self.classe = self.funcionario  if self.funcionario
  end

  def set_carteira
    if self.cliente
      if self.cliente.carteira.nil?
        carteira = Carteira.create(cliente_id: self.cliente_id) 
      else
        carteira = self.cliente.carteira
      end
      carteira.update(valor: self.cliente.saldo)
    end
  end
  
  #def criar_cc
  #  if self.carteira and self.ordem_servico_id
  #    cc = ContaCorrente.new(self.attributes)
  #    cc.id = nil
  #    cc.carteira = nil
  #    cc.tipo_lancamento_id = 1
  #    cc.save!
  #  end
  #end
end
