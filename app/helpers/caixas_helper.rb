module CaixasHelper
  def descricao_status_caixa(status)
    case status
      when 1 then "Aberto"
      when 2 then "Fechado"
      else 
        "Status Inválido"
    end
  end
end
