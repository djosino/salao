class AddUsuarioToOrdemServicos < ActiveRecord::Migration
  def change
    add_column :ordem_servicos, :usuario_id, :integer
  end
end
