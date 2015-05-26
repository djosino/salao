class AddColumsToOss < ActiveRecord::Migration
  def change
    add_column :ordem_servicos_servicos, :valor, :float
    add_column :ordem_servicos_servicos, :comissao, :float
    add_reference :ordem_servicos_servicos, :funcionario, index: true
  end
end
