class ContaCorrente < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :funcionario
  belongs_to :tipo_lancamento
end
