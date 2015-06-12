class AddNumeroToOrdemServicos < ActiveRecord::Migration
  def change
    add_column :ordem_servicos, :numero, :string
  end
end
