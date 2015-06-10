class OrdemServico < ActiveRecord::Base
  self.per_page = 30
  belongs_to :cliente
  belongs_to :usuario

  has_many :pagamentos, class_name: 'ContaCorrente'
  has_many :ordem_servicos_servicos, class_name: 'OSS'
  
  has_and_belongs_to_many :servicos

  validates_presence_of :cliente
  before_create :set_status


  def descricao_status
    case self.status
      when 1 then 'Aberta'
      when 2 then 'Fechada'
      when 3 then 'Cancelada'
      when 4 then 'Finalizada (Paga)'
      else
        'Indefinida'
    end
  end

  def remover_servico(servico_id)
    OSS.where(ordem_servico_id: self.id, servico_id: servico_id).last.destroy
  end

  def finalizar!
    self.status          = 2
    self.valor           = self.servicos.pluck(:valor).sum.to_f
    self.valor_comissao  = self.valor - (self.ordem_servicos_servicos.pluck(:funcionario_id).uniq.size * 2)
    self.save
  end

  def cancelar!
    self.status = 2
    self.save
  end

  def pendente_de_pagamento?
    (self.valor - self.pagamentos.pluck(:valor).sum) > 0
  end

  private
    def set_status
      self.status = 1
    end
end
