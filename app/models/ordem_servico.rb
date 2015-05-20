class OrdemServico < ActiveRecord::Base
  self.per_page = 30
  belongs_to :cliente
end
