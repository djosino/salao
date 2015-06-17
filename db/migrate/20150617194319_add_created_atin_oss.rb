class AddCreatedAtinOss < ActiveRecord::Migration
  def change
    add_column :ordem_servicos_servicos, :created_at, :datetime
  end
end
