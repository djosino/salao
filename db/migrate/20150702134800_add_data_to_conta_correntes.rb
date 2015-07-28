class AddDataToContaCorrentes < ActiveRecord::Migration
  def change
    add_column :conta_correntes, :data, :date
  end
end
