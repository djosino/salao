module ServicosHelper
  def servicos
    Servico.order(:descricao).pluck(:descricao, :id)
  end

  def servicos_grupos
    ret = ""
    TipoServico.order(:descricao).each do |t|
      ret += "<optgroup label='#{t.descricao}'>"
      t.servicos.order(:descricao).each do |s|
        ret += "<option value='#{s.id}'>#{s.descricao}</option>"
      end
      ret += "</optgroup>"
    end
    return ret
  end
end
