json.array!(@tipo_servicos) do |tipo_servico|
  json.extract! tipo_servico, :id, :descricao, :ativo
  json.url tipo_servico_url(tipo_servico, format: :json)
end
