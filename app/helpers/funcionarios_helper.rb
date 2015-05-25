module FuncionariosHelper
  def funcionarios
    Usuario.order(:name).pluck(:name, :id)
  end
end
