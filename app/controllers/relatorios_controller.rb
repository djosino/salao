class RelatoriosController < ApplicationController
  skip_authorize_resource
  
  def call_authorize_ability  
    authorize_ability(:relatorios)
  end
  
  def index
  end

  def movimento_de_caixa
    if request.post?
      @despesas = ContaCorrente.dia(params[:data]).debitos.order(:created_at)
      @dados = {}
      @dados.merge!( creditos_01:  ContaCorrente.dia(params[:data]).where(forma_de_pagamento_id: 1).pluck(:valor).sum )
      @dados.merge!( creditos_02:  ContaCorrente.dia(params[:data]).where(forma_de_pagamento_id: 2).pluck(:valor).sum )
      @dados.merge!( creditos_03:  ContaCorrente.dia(params[:data]).where(forma_de_pagamento_id: 3).pluck(:valor).sum )
      @dados.merge!( creditos_04:  ContaCorrente.dia(params[:data]).where(forma_de_pagamento_id: 4).pluck(:valor).sum )
      @dados.merge!( creditos_05:  ContaCorrente.dia(params[:data]).where(forma_de_pagamento_id: 5).pluck(:valor).sum )
      @dados.merge!( creditos_06:  ContaCorrente.dia(params[:data]).where(forma_de_pagamento_id: 6).pluck(:valor).sum )
      @dados.merge!( creditos_99:  ContaCorrente.dia(params[:data]).creditos.pluck(:valor).sum )

      @dados.merge!( debitos_07:   ContaCorrente.dia(params[:data]).where(forma_de_pagamento_id: 7).pluck(:valor).sum )
      @dados.merge!( debitos_08:   ContaCorrente.dia(params[:data]).where(forma_de_pagamento_id: 8).pluck(:valor).sum )
      @dados.merge!( debitos_09:   ContaCorrente.dia(params[:data]).where(forma_de_pagamento_id: 9).pluck(:valor).sum )
      @dados.merge!( debitos_99:   @despesas.pluck(:valor).sum )
      render layout: 'print4'
    end
  end

  def extrato_por_funcionario
    @dados = []
    if request.post?
      @funcionarios = Usuario.order(:id)

      @funcionarios.each do |func|
        valor = comissao = adiantamento = conta_corrente = 0

        OSS.joins(:ordem_servico).where("created_at::date = ? and funcionario_id = ?", params[:data].to_date, func.id).each do |oss|
          valor        += oss.valor
          comissao     += (oss.valor * (oss.comissao || func.comissao).to_f / 100)
        end
        adiantamento   += ContaCorrente.where("forma_de_pagamento_id = 8 and created_at::date = ? and classe_type = 'Usuario' and classe_id = ?", params[:data].to_date, func.id).pluck(:valor).sum
        conta_corrente += ContaCorrente.where("tipo_lancamento_id    = 1 and classe_type = 'Usuario' and classe_id = ?", func.id).pluck(:valor).sum
        conta_corrente -= ContaCorrente.where("tipo_lancamento_id    = 2 and classe_type = 'Usuario' and classe_id = ?", func.id).pluck(:valor).sum

        @dados << { func:         func.id, 
                    nome:         func.nome,
                    comissao:     comissao,
                    valor:        valor,
                    adiantamento: adiantamento,
                    ccorrente:    conta_corrente,
                    saldo:        conta_corrente + comissao
                  }
      end
    end
    if params[:imprimir].present?
      render layout: 'print4'
    end
  end
end
