module TipoServicosHelper
  def tipo_servicos
    TipoServico.order(:descricao).pluck(:descricao, :id)
  end
end
