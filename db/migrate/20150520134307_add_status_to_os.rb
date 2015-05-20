class AddStatusToOs < ActiveRecord::Migration
  def change
    add_column :ordem_servicos, :status, :integer
  end
end
