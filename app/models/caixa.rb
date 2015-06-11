class Caixa < ActiveRecord::Base

  belongs_to :funcionario, class_name: "Usuario", foreign_key: :funcionario_id

  validates_presence_of :status, :funcionario_id, :valor_abertura

  validate :unicidade, on: :create

  after_create :realizar_lancamento

  scope :abertos,     -> { where(status: 1) }

  def realizar_lancamento
    ContaCorrente.create(tipo_lancamento_id: 1, valor: self.valor_abertura, forma_de_pagamento_id: 3, classe_type: 'Funcionario', classe_id: self.funcionario_id, observacao: "FUNDO FIXO")
    ContaCorrente.create(tipo_lancamento_id: 2, valor: self.valor_abertura, forma_de_pagamento_id: 9, classe_type: 'Funcionario', classe_id: self.funcionario_id, observacao: "FUNDO FIXO")
  end

  def unicidade
    if Caixa.abertos.count > 0
      errors.add(:base, 'Já existe um caixa aberto !') 
      return false
    end
  end
end
