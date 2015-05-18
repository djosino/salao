# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
   inflect.irregular 'feria',    'ferias'
   inflect.irregular 'viagem',    'viagens'
   inflect.irregular 'tipo_contato',    'tipos_contatos'
   inflect.irregular 'tipo_documento',  'tipos_documentos'
   inflect.irregular 'tipo_etapa',      'tipos_etapas'
   inflect.irregular 'log_validacao',   'log_validacoes'
   inflect.irregular 'manutencao',      'manutencoes'
   inflect.irregular 'tipo_manutencao', 'tipos_manutencoes'
#   inflect.uncountable %w( fish sheep )

end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end
