class Servico < ActiveRecord::Base
  self.per_page = 30
  has_and_belongs_to_many :ordem_servicos
  belongs_to :tipo_servico
  validates_presence_of :descricao, :valor, :percentual, :tipo_servico_id
end
