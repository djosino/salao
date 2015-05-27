class TipoLancamentoToFormaPagamento < ActiveRecord::Migration
  def change
    add_column :forma_de_pagamentos, :tipo_lancamento_id, :integer
  end
end
