class AddCamposToUsuario < ActiveRecord::Migration
  def change
    add_column :usuarios, :sexo,        :string
    add_column :usuarios, :profissao,   :string
    add_column :usuarios, :cep,         :integer
    add_column :usuarios, :endereco,    :string
    add_column :usuarios, :numero,      :integer
    add_column :usuarios, :complemento, :string
    add_column :usuarios, :bairro,      :string
    add_column :usuarios, :cidade,      :string
    add_column :usuarios, :estado,      :string
    add_column :usuarios, :fone,        :string
    add_column :usuarios, :fone2,       :string
    add_column :usuarios, :nascimento,  :date
  end
end
