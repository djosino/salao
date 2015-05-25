class ContaCorrente < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :funcionario, class: "Usuario", foreign_key: :funcionario_id
  belongs_to :tipo_lancamento

  belongs_to :classe, :polymorphic => true 

  validates_presence_of :valor, :observacao, :tipo_lancamento
  validate :cliente_ou_funcionario

  def cliente_ou_funcionario
    if self.cliente.nil? and self.funcionario.nil?
      errors.add(:base, 'Informe um Cliente ou Funcionario') 
      return false
    end
    self.classe = self.cliente      if self.cliente
    self.classe = self.funcionario  if self.funcionario
  end
end
