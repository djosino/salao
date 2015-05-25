class CreateCarteiras < ActiveRecord::Migration
  def change
    create_table :carteiras do |t|
      t.references :cliente, index: true
      t.float :valor

      t.timestamps
    end
  end
end
