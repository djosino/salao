class TipoServico < ActiveRecord::Base
  validates_presence_of :descricao
  has_many :servicos
end
