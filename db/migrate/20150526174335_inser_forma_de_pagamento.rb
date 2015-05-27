class InserFormaDePagamento < ActiveRecord::Migration
  def change
    FormaDePagamento.create(descricao: "DINHEIRO")
    FormaDePagamento.create(descricao: "CHEQUE DO DIA")
    FormaDePagamento.create(descricao: "CHEGQUE PRE")
    FormaDePagamento.create(descricao: "CARTÕES")
    FormaDePagamento.create(descricao: "CONTA CORRENTE")
    FormaDePagamento.create(descricao: "CONVÊNIOS")
  end
end
