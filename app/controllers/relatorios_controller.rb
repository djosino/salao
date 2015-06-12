class RelatoriosController < ApplicationController
  skip_authorize_resource
  
  def call_authorize_ability  
    authorize_ability(:relatorios)
  end
  
  def index
  end

  def movimento_de_caixa
    if request.post?
      creditos = ContaCorrente.creditos.dia(params[:data])
      debitos  = ContaCorrente.debitos.dia(params[:data])
      @despesas  = debitos.where(forma_de_pagamento_id: [7,8,9]).order(:created_at)

      @dados = {}
      @dados.merge!( creditos_00:  creditos.where(forma_de_pagamento_id: 10).pluck(:valor).sum )
      @dados.merge!( creditos_01:  creditos.where(forma_de_pagamento_id: 1).pluck(:valor).sum )
      @dados.merge!( creditos_02:  creditos.where(forma_de_pagamento_id: 2).pluck(:valor).sum )
      @dados.merge!( creditos_03:  creditos.where(forma_de_pagamento_id: 3).pluck(:valor).sum )
      @dados.merge!( creditos_04:  creditos.where(forma_de_pagamento_id: 4).pluck(:valor).sum )
      @dados.merge!( creditos_05:  creditos.where(forma_de_pagamento_id: 5).pluck(:valor).sum )
      @dados.merge!( creditos_06:  creditos.where(forma_de_pagamento_id: 6).pluck(:valor).sum )
      @dados.merge!( creditos_99:  creditos.where(forma_de_pagamento_id: [1,2,3,4,5,6,10]).pluck(:valor).sum )

      @dados.merge!( debitos_07:   debitos.where(forma_de_pagamento_id: 7).pluck(:valor).sum )
      @dados.merge!( debitos_08:   debitos.where(forma_de_pagamento_id: 8).pluck(:valor).sum )
      @dados.merge!( debitos_09:   debitos.where(forma_de_pagamento_id: 9).pluck(:valor).sum )
      @dados.merge!( debitos_99:   @despesas.where(forma_de_pagamento_id: [7,8,9]).pluck(:valor).sum )
      render layout: 'print4'
    end
  end

  def extrato_por_funcionario
    @dados = []
    if request.post?
      @funcionarios = Usuario.where('percentual > 0').order(:id)
      
      @funcionarios.each do |func|
        valor = comissao = adiantamento = conta_corrente = 0
        descontado = []
        OSS.joins(:ordem_servico).where("created_at::date = ? and funcionario_id = ?", params[:data].to_date, func.id).order(comissao: :desc).each do |oss|
          desconto      = (descontado.include?(oss.id) ? 0 : 2)
          descontado   << oss.id
          valor        += oss.valor
          comissao     += ((oss.valor - desconto) * (oss.comissao || func.comissao).to_f / 100)
        end
        adiantamento   += ContaCorrente.where("forma_de_pagamento_id = 8 and created_at::date = ? and classe_type = 'Usuario' and classe_id = ?", params[:data].to_date, func.id).pluck(:valor).sum
        
        @dados << { func:         func.id, 
                    nome:         func.nome,
                    valor:        valor,
                    comissao:     comissao,
                    adiantamento: adiantamento,
                    saldo:        comissao - adiantamento
                  }
      end
    end
    if params[:imprimir].present?
      render layout: 'print4'
    end
  end

  def pagamento_funcionario
    if request.post?
      @funcionario = Usuario.find(params[:funcionario_id])

      @lancamentos  = ContaCorrente.where("tipo_lancamento_id = 2 and created_at::date between ? and ? and classe_type = 'Usuario' and classe_id = ?", params[:data_ini].to_date, params[:data_fim].to_date, @funcionario.id).order(:id)
    end
    if params[:imprimir].present?
      render layout: 'print4'
    end
  end
end
