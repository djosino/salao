class Caixa < ActiveRecord::Base

  belongs_to :funcionario, class_name: "Usuario", foreign_key: :funcionario_id

  validates_presence_of :status, :funcionario_id, :valor_abertura

  validate :unicidade, on: :create

  scope :abertos,     -> { where(status: 1) }
  scope :fechados,    -> { where(status: 2) }

  def lancamento_credito
    # tipo_lancamento: Crédito, forma_de_pagamento: Dinheiro
    ContaCorrente.create({tipo_lancamento_id: 1, valor: self.valor_abertura, forma_de_pagamento_id: 1, classe_type: 'Funcionario', classe_id: self.funcionario_id, observacao: "FUNDO FIXO - Abertura", funcionario_id: self.funcionario_id})
  end
  
  def lancamento_debito
    # tipo_lancamento: Debito, forma_de_pagamento: Despesas
    ContaCorrente.create({tipo_lancamento_id: 2, valor: self.valor_abertura, forma_de_pagamento_id: 9, classe_type: 'Funcionario', classe_id: self.funcionario_id, observacao: "FUNDO FIXO - Fechamento", funcionario_id: self.funcionario_id})
  end

  def unicidade
    if Caixa.abertos.count > 0
      errors.add(:base, 'Já existe um caixa aberto !') 
      return false
    end
  end
end
