class OrdemServico < ActiveRecord::Base
  self.per_page = 30
  belongs_to :cliente
  belongs_to :usuario
  
  has_and_belongs_to_many :servicos

  validates_presence_of :cliente
  before_create :set_status


  def descricao_status
    case self.status
      when 1 then 'Aberta'
      when 2 then 'Fechada'
      when 3 then 'Cancelada'
      else
        'Indefinida'
    end
  end

  private
  def set_status
    self.status = 1
  end

end
