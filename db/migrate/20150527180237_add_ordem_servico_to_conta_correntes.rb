class AddOrdemServicoToContaCorrentes < ActiveRecord::Migration
  def change
    add_column :conta_correntes, :ordem_servico_id, :integer
  end
end
