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

ActiveRecord::Schema.define(version: 20150520164127) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agendas", force: true do |t|
    t.integer  "semana"
    t.integer  "cartorio_id"
    t.integer  "equipe_id"
    t.integer  "usuario_id"
    t.integer  "user_last_changed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status_agenda_id",     default: 1
  end

  add_index "agendas", ["cartorio_id"], name: "index_agendas_on_cartorio_id", using: :btree
  add_index "agendas", ["equipe_id"], name: "index_agendas_on_equipe_id", using: :btree
  add_index "agendas", ["usuario_id"], name: "index_agendas_on_usuario_id", using: :btree

  create_table "campos", force: true do |t|
    t.integer  "tipo_documento_id"
    t.string   "descricao"
    t.string   "tipo_de_dado"
    t.string   "observacao"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "cartorios", force: true do |t|
    t.string   "nome"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "usuario_cadastro_id"
    t.string   "local_path"
    t.string   "uf"
    t.string   "bairro"
    t.string   "endereco"
    t.string   "numero"
    t.string   "telefone"
    t.string   "cep"
    t.string   "complemento"
    t.string   "representante"
    t.integer  "cidade_id"
    t.string   "logradouro"
    t.integer  "status_cartorio_id",  default: 1
    t.string   "cnpj"
    t.float    "valor"
  end

  create_table "cidades", force: true do |t|
    t.string   "nome"
    t.string   "cod"
    t.string   "uf"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "contatos", force: true do |t|
    t.text     "observacao"
    t.date     "data"
    t.datetime "retorno"
    t.integer  "cartorio_id"
    t.integer  "usuario_id"
    t.integer  "tipo_contato_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nome"
  end

  create_table "documentos", force: true do |t|
    t.integer  "numero_documento"
    t.integer  "lote_id"
    t.integer  "tipo_documento_id"
    t.boolean  "aprovado_cq1"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.boolean  "aprovado_cq2"
    t.boolean  "aprovado_cq3"
    t.integer  "parent_id"
    t.boolean  "indexado"
    t.string   "texto",                limit: nil
    t.tsvector "vectors"
    t.date     "data_protocolo"
    t.string   "nome_origem"
    t.integer  "paginas",                          default: 1
    t.boolean  "aprovado_conferencia"
    t.datetime "cq2_em"
    t.boolean  "marcar_remover"
    t.datetime "conferido_em"
    t.boolean  "corrigido"
    t.text     "observacao"
    t.boolean  "aprovado_ocr"
    t.boolean  "scannergrande"
  end

  add_index "documentos", ["data_protocolo"], name: "index_data_protocolo", using: :btree
  add_index "documentos", ["tipo_documento_id"], name: "index_tipo_documento_id", using: :btree
  add_index "documentos", ["vectors"], name: "index_full_text", using: :gist

  create_table "empresas", force: true do |t|
    t.string   "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "equipes", force: true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "equipes_usuarios", force: true do |t|
    t.integer "equipe_id"
    t.integer "usuario_id"
  end

  create_table "etapas", force: true do |t|
    t.integer  "lote_id"
    t.integer  "tipo_etapa_id"
    t.boolean  "concluida"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "etapas", ["created_by"], name: "index_etapas_on_created_by", using: :btree
  add_index "etapas", ["lote_id"], name: "index_etapas_on_lote_id", using: :btree
  add_index "etapas", ["tipo_etapa_id"], name: "index_etapas_on_tipo_etapa_id", using: :btree
  add_index "etapas", ["updated_by"], name: "index_etapas_on_updated_by", using: :btree

  create_table "forma_de_pagamentos", force: true do |t|
    t.string   "descricao"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "indexacoes", force: true do |t|
    t.integer  "documento_id"
    t.integer  "campo_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "valor_inteiro"
    t.float    "valor_decimal"
    t.date     "valor_data"
    t.datetime "valor_datahora"
    t.boolean  "valor_boleano"
    t.text     "valor_texto"
  end

  add_index "indexacoes", ["campo_id"], name: "index_indexacoes_on_campo_id", using: :btree
  add_index "indexacoes", ["documento_id"], name: "index_indexacoes_on_documento_id", using: :btree

  create_table "log_validacaos", force: true do |t|
    t.integer  "user_id"
    t.integer  "documento_id"
    t.integer  "lote_id"
    t.integer  "cliente_id"
    t.integer  "tipo"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "log_validacaos", ["cliente_id"], name: "index_log_validacaos_on_cliente_id", using: :btree
  add_index "log_validacaos", ["documento_id"], name: "index_log_validacaos_on_documento_id", using: :btree
  add_index "log_validacaos", ["lote_id"], name: "index_log_validacaos_on_lote_id", using: :btree
  add_index "log_validacaos", ["user_id"], name: "index_log_validacaos_on_user_id", using: :btree

  create_table "lotes", force: true do |t|
    t.string   "numero_lote"
    t.integer  "tipo_documento_id"
    t.integer  "qt_doc"
    t.integer  "qt_pag"
    t.integer  "usuario_id"
    t.integer  "usuario_ultima_alteracao"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "cliente_id"
    t.integer  "usuario_conferencia_id"
    t.integer  "usuario_cq2_id"
    t.boolean  "pode_conferir"
    t.string   "observacao"
    t.string   "livro"
  end

  add_index "lotes", ["cliente_id"], name: "index_lotes_on_cliente_id", using: :btree

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

  create_table "parametros", force: true do |t|
    t.string   "chave"
    t.string   "valor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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
  end

  create_table "status_agendas", force: true do |t|
    t.string   "descricao"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "status_cartorios", force: true do |t|
    t.string   "descricao"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tipo_documentos", force: true do |t|
    t.string   "descricao"
    t.string   "observacao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tipo_etapas", force: true do |t|
    t.string   "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tipos_contatos", force: true do |t|
    t.string   "descricao"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usuarios", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 5
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "entidade_id"
    t.boolean  "master"
    t.boolean  "gerente"
    t.boolean  "indexador"
    t.boolean  "conferente"
    t.integer  "cliente_id"
    t.string   "entidade_type"
    t.integer  "roles_mask"
    t.string   "roles_string",           default: ""
    t.string   "nome"
    t.string   "celular"
    t.string   "telefone"
    t.float    "valor_fixo"
    t.float    "percentual"
  end

  add_index "usuarios", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "usuarios", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "usuarios", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "usuarios", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",            null: false
    t.integer  "item_id",              null: false
    t.string   "event",                null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.integer  "user_last_changed_id"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "viagens", force: true do |t|
    t.date     "inicio"
    t.date     "termino_previsto"
    t.date     "termino"
    t.float    "custo"
    t.string   "observacao"
    t.integer  "cartorio_id"
    t.integer  "equipe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "agenda_id"
  end

end
