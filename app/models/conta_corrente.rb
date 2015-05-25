class ContaCorrente < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :funcionario, class: "Usuario", foreign_key: :funcionario_id
  belongs_to :tipo_lancamento

  belongs_to :classe, :polymorphic => true 

  validates_presence_of :valor, :observacao, :tipo_lancamento
  validate :cliente_ou_funcionario
  after_save :set_carteira

  def cliente_ou_funcionario
    if self.cliente.nil? and self.funcionario.nil?
      errors.add(:base, 'Informe um Cliente ou Funcionario') 
      return false
    end
    self.classe = self.cliente      if self.cliente
    self.classe = self.funcionario  if self.funcionario
  end

  def set_carteira
    if self.cliente
      if self.cliente.carteira.nil?
        carteira = Carteira.create(cliente_id: self.cliente_id) 
      else
        carteira = self.cliente.carteira
      end
      carteira.update(valor: self.cliente.saldo)
    end
  end
end
