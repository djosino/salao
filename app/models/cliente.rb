class Cliente < ActiveRecord::Base
  self.per_page = 50
  validates_presence_of :nome, :telefone
  has_many :conta_correntes

  def saldo
    self.conta_correntes.where(tipo_lancamento_id: 1).select("sum(valor)")[0].sum.to_f - 
    self.conta_correntes.where(tipo_lancamento_id: 2).select("sum(valor)")[0].sum.to_f
  end
end
