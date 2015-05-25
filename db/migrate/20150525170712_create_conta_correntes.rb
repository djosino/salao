class CreateContaCorrentes < ActiveRecord::Migration
  def change
    create_table :conta_correntes do |t|
      t.references :cliente, index: true
      t.references :funcionario, index: true
      t.references :tipo_lancamento, index: true
      t.float :valor
      t.string :observacao

      t.timestamps
    end
  end
end
