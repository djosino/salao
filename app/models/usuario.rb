class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :lockable, :timeoutable, :registerable,
         :recoverable, :encryptable, encryptor: :restful_authentication_sha1, authentication_keys: [:login]

  belongs_to :entidade, :polymorphic => true

  # SCOPEs 
  #default_scope { order("email asc") }
  scope :liberados,        -> { where(locked_at: nil) }
  scope :atendentes,       -> { where("roles_string like 'atendente'")     }
  scope :gerentes,         -> { where("roles_string like 'gerente'")       }
  scope :administradores,  -> { where("roles_string like 'administrador'") }
  scope :ponto_eletronico, -> { (indexadores + atendentes + administradores + gerentes).uniq }
  #scope :indexadores, -> { where(indexador:  true) }
  #scope :conferentes, -> { where(conferente: true) }
  #scope :gerentes,    -> { where(gerente:    true) }

  scope :por_permissao,    -> { order(locked_at: :desc, roles_mask: :desc, nome: :asc) }

  ROLES = %w(atendente gerente administrador)

  validates_presence_of :email, :nome, :percentual #, :entidade_id, :entidade_type

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

  def nome
    name
  end

  def nome=(arg)
    name=arg
  end

  # DeviseLogin with login field
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(login) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end
