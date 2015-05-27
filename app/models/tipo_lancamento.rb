class TipoLancamento < ActiveRecord::Base
  has_many :forma_de_pagamentos
end
