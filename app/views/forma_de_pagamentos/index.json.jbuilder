json.array!(@forma_de_pagamentos) do |forma_de_pagamento|
  json.extract! forma_de_pagamento, :id, :descricao
  json.url forma_de_pagamento_url(forma_de_pagamento, format: :json)
end
