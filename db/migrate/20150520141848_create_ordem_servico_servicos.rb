class CreateOrdemServicoServicos < ActiveRecord::Migration
  def change
    create_table :ordem_servicos_servicos do |t|
      t.belongs_to :ordem_servico, index: true
      t.belongs_to :servico, index: true
    end
  end
end
