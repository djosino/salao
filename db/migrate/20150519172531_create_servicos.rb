class CreateServicos < ActiveRecord::Migration
  def change
    create_table :servicos do |t|
      t.string :descricao
      t.float :percentual
      t.float :valor

      t.timestamps
    end

    add_column :usuarios, :valor_fixo, :float
    add_column :usuarios, :percentual, :float
  end
end
