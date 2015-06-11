json.array!(@caixas) do |caixa|
  json.extract! caixa, :id, :status, :funcionario_id, :valor_abertura, :aberto_em, :valor_fechamento, :fechado_em
  json.url caixa_url(caixa, format: :json)
end
