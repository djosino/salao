class AddCarteiraInContaCorrentes < ActiveRecord::Migration
  def change
    add_column :conta_correntes, :carteira, :boolean
  end
end
