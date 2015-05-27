class AddFormaDePagamentoToContaCorrente < ActiveRecord::Migration
  def change
    add_column :conta_correntes, :forma_de_pagamento_id, :integer
  end
end
