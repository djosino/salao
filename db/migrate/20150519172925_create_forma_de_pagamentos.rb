class CreateFormaDePagamentos < ActiveRecord::Migration
  def change
    create_table :forma_de_pagamentos do |t|
      t.string :descricao

      t.timestamps
    end
  end
end
