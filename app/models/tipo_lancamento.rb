class TipoLancamento < ActiveRecord::Base
  has_many :forma_de_pagamentos
    
  ##<TipoLancamento id: 1, descricao: "Crédito", created_at: "2015-05-25 17:09:47", updated_at: "2015-05-25 17:09:47" 
  ##<TipoLancamento id: 2, descricao: "Débito", created_at: "2015-05-25 17:09:47", updated_at: "2015-05-25 17:09:47">

end
