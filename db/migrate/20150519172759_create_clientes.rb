class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :nome
      t.string :cpf
      t.string :cep
      t.string :endereco
      t.string :numero
      t.string :bairro
      t.string :data_nascimento
      t.string :email
      t.string :telefone
      t.string :telefone2

      t.timestamps
    end
  end
end
