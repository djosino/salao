module ServicosHelper
	def servicos
    Servico.order(:descricao).pluck(:descricao, :id)
  end
end
