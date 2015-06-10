class ValorComissaoToOss < ActiveRecord::Migration
  def change
    add_column :ordem_servicos, :valor_comissao, :float
  end
end
