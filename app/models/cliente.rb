class Cliente < ActiveRecord::Base
  self.per_page = 50
  validates_presence_of :nome, :telefone
  has_many :conta_correntes
  has_one :carteira

  def saldo
    self.conta_correntes.where(tipo_lancamento_id: 1, carteira: true).select("sum(valor)")[0].sum.to_f - 
    self.conta_correntes.where(tipo_lancamento_id: 2, carteira: true).select("sum(valor)")[0].sum.to_f
  end

  def saldo_periodo(inicio, fim)
    cond = ["created_at::date between ? and ?"]
    cond << inicio.to_date
    cond << fim.to_date

    self.conta_correntes.where(tipo_lancamento_id: 1, carteira: true).where(cond).select("sum(valor)")[0].sum.to_f - 
    self.conta_correntes.where(tipo_lancamento_id: 2, carteira: true).where(cond).select("sum(valor)")[0].sum.to_f
  end
end
