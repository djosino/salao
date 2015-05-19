class Servico < ActiveRecord::Base
  self.per_page = 30
  validates_presence_of :descricao, :valor
end
