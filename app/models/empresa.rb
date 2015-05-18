class Empresa < ActiveRecord::Base
  has_many :usuarios, :as => :entidade

  ROLES = %w(empresa_atendente empresa_viagem empresa_gerente empresa_administrador empresa_indexador empresa_gerente_indexacao)
  
  validates_presence_of :nome
  
end
