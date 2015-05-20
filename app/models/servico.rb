class Servico < ActiveRecord::Base
  self.per_page = 30
  has_and_belongs_to_many :ordem_servicos
  validates_presence_of :descricao, :valor
end
