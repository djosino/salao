module ClientesHelper
  def clientes
    Cliente.order(:nome).pluck(:nome, :id)
  end
end
