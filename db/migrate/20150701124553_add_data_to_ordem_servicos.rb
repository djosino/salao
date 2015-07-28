class AddDataToOrdemServicos < ActiveRecord::Migration
  def change
    add_column :ordem_servicos, :data, :date
  end
end
