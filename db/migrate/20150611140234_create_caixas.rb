class CreateCaixas < ActiveRecord::Migration
  def change
    create_table :caixas do |t|
      t.integer :status
      t.integer :funcionario_id
      t.float :valor_abertura
      t.datetime :aberto_em
      t.float :valor_fechamento
      t.datetime :fechado_em

      t.timestamps
    end
  end
end
