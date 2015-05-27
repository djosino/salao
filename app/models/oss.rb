class OSS < ActiveRecord::Base
  self.table_name = :ordem_servicos_servicos

  belongs_to :servico
  belongs_to :ordem_servico
end
