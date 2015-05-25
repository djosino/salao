class CreateTipoServicos < ActiveRecord::Migration
  def change
    create_table :tipo_servicos do |t|
      t.string :descricao
      t.boolean :ativo

      t.timestamps
    end

    add_column :servicos, :tipo_servico_id, :integer
  end
end
