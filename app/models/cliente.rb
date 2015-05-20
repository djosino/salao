class Cliente < ActiveRecord::Base
  self.per_page = 50
  validates_presence_of :nome, :telefone
end
