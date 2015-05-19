json.array!(@clientes) do |cliente|
  json.extract! cliente, :id, :nome, :cpf, :cep, :endereco, :numero, :bairro, :data_nascimento, :email, :telefone, :telefone2
  json.url cliente_url(cliente, format: :json)
end
