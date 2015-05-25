class AddClasseToContaCorrentes < ActiveRecord::Migration
  def change
    add_column :conta_correntes, :classe, :string
  end
end
