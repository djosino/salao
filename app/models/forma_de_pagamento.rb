class FormaDePagamento < ActiveRecord::Base
  self.per_page = 30
  belongs_to :tipo_lancamento
end
