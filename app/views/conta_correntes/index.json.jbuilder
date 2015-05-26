json.array!(@conta_correntes) do |conta_corrente|
  json.extract! conta_corrente, :id, :cliente_id, :funcionario_id, :tipo_lancamento_id, :valor, :observacao
  json.url conta_corrente_url(conta_corrente, format: :json)
end
