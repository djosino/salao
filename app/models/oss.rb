class OSS < ActiveRecord::Base
  self.table_name = :ordem_servicos_servicos

  belongs_to :servico
  belongs_to :ordem_servico
  belongs_to :funcionario, class_name: 'Usuario'

  validates_presence_of :servico, :ordem_servico, :funcionario_id, :valor
end
