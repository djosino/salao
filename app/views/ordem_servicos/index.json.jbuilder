json.array!(@ordem_servicos) do |ordem_servico|
  json.extract! ordem_servico, :id, :cliente_id, :valor
  json.url ordem_servico_url(ordem_servico, format: :json)
end
