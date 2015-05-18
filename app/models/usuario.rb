class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :timeoutable,
         :rememberable, :trackable, :validatable, :lockable #, :confirmable, 

  belongs_to :entidade, :polymorphic => true

  # SCOPEs 
  #default_scope { order("email asc") }
  scope :liberados,        -> { where(locked_at: nil) }
  scope :equipe_viagem,    -> { where("roles_string like '%viagem%'")        }
  scope :indexadores,      -> { where("roles_string like '%indexador%'")     }
  scope :gerentes,         -> { where("roles_string like '%gerente%'")       }
  scope :atendentes,       -> { where("roles_string like '%atendente%'")     }
  scope :administradores,  -> { where("roles_string like '%administrador%'") }
  scope :ponto_eletronico, -> { (indexadores + atendentes + administradores + gerentes).uniq }
  #scope :indexadores, -> { where(indexador:  true) }
  #scope :conferentes, -> { where(conferente: true) }
  #scope :gerentes,    -> { where(gerente:    true) }

  scope :por_permissao,    -> { order(locked_at: :desc, roles_mask: :desc, nome: :asc) }

  ROLES = %w(empresa_atendente empresa_viagem empresa_gerente empresa_administrador empresa_indexador empresa_gerente_indexacao)

  validates_presence_of :email, :nome, :entidade_id, :entidade_type

  def lock_unlock!
    self.locked_at.nil? ? self.lock_access! : self.unlock_access!
  end
  
  def roles=(roles)
    roles = %w(roles) if roles.class == String
    self.roles_mask   = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
    self.roles_string = self.roles * ','
  end
  
  def roles
    ROLES.reject do |r|
      ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def is?(role)
    roles.include?(role.to_s)
  end

  def in?(roles)
    roles.each do |role|
      if self.is?(role)
        return true
      end
    end
    return false
  end

  def empresa?
    self.entidade_type == 'Empresa'
  end

  def cartorio?
    self.entidade_type == 'Cartorio'
  end

  def add_role!(new_role)
    roles      = self.roles  || []
    roles     << new_role
    self.roles = roles
    self.save
  end

  def remove_role!(old_role = nil)
    roles = self.roles 
    roles.delete(old_role)
    self.save
  end

  def generate_roles
    self.roles = self.roles_string.split(%r{,\s*})
  end

end
