class TipoServico < ActiveRecord::Base
  validates_presence_of :descricao
end
