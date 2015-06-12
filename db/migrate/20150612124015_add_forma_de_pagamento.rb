class AddFormaDePagamento < ActiveRecord::Migration
  def change
    FormaDePagamento.create(descricao: "FUNDO FIXO",      tipo_lancamento_id: 1)
  end
end