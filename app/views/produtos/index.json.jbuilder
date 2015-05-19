json.array!(@produtos) do |produto|
  json.extract! produto, :id, :descricao, :valor
  json.url produto_url(produto, format: :json)
end
