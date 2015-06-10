class AttDadosFormaDePagamento < ActiveRecord::Migration
  def change
    FormaDePagamento.update_all(tipo_lancamento_id: 1)
    FormaDePagamento.create(descricao: "RETIRADAS",     tipo_lancamento_id: 2)
    FormaDePagamento.create(descricao: "ADIANTAMENTOS", tipo_lancamento_id: 2)
    FormaDePagamento.create(descricao: "DESPESAS",      tipo_lancamento_id: 2)
  end
end
