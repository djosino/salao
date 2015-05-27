module ClientesHelper
  def clientes
    Cliente.order(:nome).pluck(:nome, :id)
  end

  def tipos_consulta_cliente
    [['CPF',  1],
     ['NOME', 2]]
  end
end
