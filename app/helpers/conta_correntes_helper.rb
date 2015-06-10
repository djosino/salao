module ContaCorrentesHelper
  def formas_pagamento_debito
    FormaDePagamento.where(tipo_lancamento_id: 1).order(:id).pluck(:descricao, :id)
  end

  def formas_pagamento_credito
    FormaDePagamento.where(tipo_lancamento_id: 2).order(:id).pluck(:descricao, :id)
  end
end
