# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150525190239) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carteiras", force: true do |t|
    t.integer  "cliente_id"
    t.float    "valor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "carteiras", ["cliente_id"], name: "index_carteiras_on_cliente_id", using: :btree

  create_table "clientes", force: true do |t|
    t.string   "nome"
    t.string   "cpf"
    t.string   "cep"
    t.string   "endereco"
    t.string   "numero"
    t.string   "bairro"
    t.string   "data_nascimento"
    t.string   "email"
    t.string   "telefone"
    t.string   "telefone2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conta_correntes", force: true do |t|
    t.integer  "cliente_id"
    t.integer  "funcionario_id"
    t.integer  "tipo_lancamento_id"
    t.float    "valor"
    t.string   "observacao"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "classe_id"
    t.string   "classe_type"
  end

  add_index "conta_correntes", ["cliente_id"], name: "index_conta_correntes_on_cliente_id", using: :btree
  add_index "conta_correntes", ["funcionario_id"], name: "index_conta_correntes_on_funcionario_id", using: :btree
  add_index "conta_correntes", ["tipo_lancamento_id"], name: "index_conta_correntes_on_tipo_lancamento_id", using: :btree

  create_table "forma_de_pagamentos", force: true do |t|
    t.string   "descricao"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ordem_servicos", force: true do |t|
    t.integer  "cliente_id"
    t.float    "valor"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
    t.integer  "usuario_id"
  end

  add_index "ordem_servicos", ["cliente_id"], name: "index_ordem_servicos_on_cliente_id", using: :btree

  create_table "ordem_servicos_servicos", force: true do |t|
    t.integer "ordem_servico_id"
    t.integer "servico_id"
  end

  add_index "ordem_servicos_servicos", ["ordem_servico_id"], name: "index_ordem_servicos_servicos_on_ordem_servico_id", using: :btree
  add_index "ordem_servicos_servicos", ["servico_id"], name: "index_ordem_servicos_servicos_on_servico_id", using: :btree

  create_table "produtos", force: true do |t|
    t.string   "descricao"
    t.float    "valor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "servicos", force: true do |t|
    t.string   "descricao"
    t.float    "percentual"
    t.float    "valor"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tipo_servico_id"
  end

  create_table "tipo_lancamentos", force: true do |t|
    t.string   "descricao"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tipo_servicos", force: true do |t|
    t.string   "descricao"
    t.boolean  "ativo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usuarios", force: true do |t|
    t.string   "login"
    t.string   "name",                          limit: 100, default: ""
    t.string   "email",                         limit: 100
    t.string   "crypted_password",              limit: 40
    t.string   "salt",                          limit: 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",                limit: 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",               limit: 40
    t.datetime "activated_at"
    t.boolean  "admin",                                     default: false
    t.integer  "cartorio_id"
    t.boolean  "master"
    t.integer  "entidade_id"
    t.string   "entidade_type"
    t.boolean  "supervisor_master",                         default: false
    t.boolean  "supervisor_entidade",                       default: false
    t.boolean  "gerente_financeiro_master",                 default: false
    t.boolean  "gerente_financeiro_entidade",               default: false
    t.boolean  "primeiro_acesso"
    t.boolean  "acesso_controle_fisico"
    t.boolean  "flag_ressarcimento_view"
    t.boolean  "flag_ressarcimento_save"
    t.boolean  "bloquear_cartorio"
    t.boolean  "visualizar_bloqueio"
    t.boolean  "flag_usuario_capital"
    t.boolean  "flag_cadastro_de_msg"
    t.boolean  "cadastra_selo_excecao"
    t.boolean  "flg_alterar_data_autenticacao"
    t.boolean  "acesso_limitado_cartorio"
    t.boolean  "administrador_cartorio"
    t.boolean  "flg_admin_crv"
    t.string   "encrypted_password",            limit: 128, default: "",    null: false
    t.string   "password_salt",                             default: "",    null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",                             default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "remember_created_at"
    t.integer  "roles_mask"
    t.text     "roles_string",                              default: ""
    t.float    "valor_fixo"
    t.float    "percentual"
    t.string   "sexo"
    t.string   "profissao"
    t.integer  "cep"
    t.string   "endereco"
    t.integer  "numero"
    t.string   "complemento"
    t.string   "bairro"
    t.string   "cidade"
    t.string   "estado"
    t.string   "fone"
    t.string   "fone2"
    t.date     "nascimento"
  end

  add_index "usuarios", ["cartorio_id"], name: "index_usuarios_on_cartorio_id", using: :btree
  add_index "usuarios", ["login"], name: "index_usuarios_on_login", unique: true, using: :btree
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true, using: :btree
  add_index "usuarios", ["unlock_token"], name: "index_usuarios_on_unlock_token", unique: true, using: :btree

end
