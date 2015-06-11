class ContaCorrente < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :funcionario, class_name: "Usuario", foreign_key: :funcionario_id
  belongs_to :tipo_lancamento
  belongs_to :forma_de_pagamento

  belongs_to :classe, :polymorphic => true 

  validates_presence_of :valor, :observacao, :tipo_lancamento, :forma_de_pagamento_id
  validate :cliente_ou_funcionario
  after_save :set_carteira

  scope :clientes,     -> { where(classe_type: "Cliente") }
  scope :funcionarios, -> { where(classe_type: "Usuario") }
  scope :creditos,     -> { where(tipo_lancamento_id: 1) }
  scope :debitos,      -> { where(tipo_lancamento_id: 2) }
  scope :dia,          -> (data) { where("created_at::date = ?", data.to_date) }

  def cliente_ou_funcionario
    if self.cliente.nil? and self.funcionario.nil?
      errors.add(:base, 'Informe um Cliente ou Funcionario') 
      return false
    end
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
end
