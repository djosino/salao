class CreateOrdemServicos < ActiveRecord::Migration
  def change
    create_table :ordem_servicos do |t|
      t.references :cliente, index: true
      t.float :valor

      t.timestamps
    end
  end
end
