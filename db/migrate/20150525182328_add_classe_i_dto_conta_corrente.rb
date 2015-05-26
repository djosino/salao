class AddClasseIDtoContaCorrente < ActiveRecord::Migration
  def change
     add_column :conta_correntes, :classe_id, :integer
     add_column :conta_correntes, :classe_type, :string
     remove_column :conta_correntes, :classe
  end
end
