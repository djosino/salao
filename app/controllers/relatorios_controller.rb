class RelatoriosController < ApplicationController
  skip_authorize_resource
  
  def call_authorize_ability  
    authorize_ability(:relatorios)
  end
  
  def index
  end

  def movimento_de_caixa
    if request.post?
      creditos = ContaCorrente.creditos.dia(params[:data].to_date)
      debitos  = ContaCorrente.debitos.dia(params[:data].to_date)
      @despesas  = debitos.where(forma_de_pagamento_id: [7,8,9]).order(:created_at)
      clientes = ContaCorrente.dia(params[:data].to_date).clientes.where("forma_de_pagamento_id = 5 and ordem_servico_id is not null and tipo_lancamento_id = 2 and carteira is true").pluck(:valor).sum.to_f
      cred_cli  = ContaCorrente.dia(params[:data].to_date).clientes.where("tipo_lancamento_id = 1 and carteira is true")
      #caixa = Caixa.where("created_at::date = ?", params[:data].to_date).pluck(:valor_abertura).sum.to_f
      @dados = {}
      @dados.merge!( creditos_00:  creditos.where(forma_de_pagamento_id: 10).pluck(:valor).sum + cred_cli.where(forma_de_pagamento_id: 10).pluck(:valor).sum )
      @dados.merge!( creditos_01:  creditos.where(forma_de_pagamento_id: 1).pluck(:valor).sum + cred_cli.where(forma_de_pagamento_id: 1).pluck(:valor).sum )
      @dados.merge!( creditos_02:  creditos.where(forma_de_pagamento_id: 2).pluck(:valor).sum + cred_cli.where(forma_de_pagamento_id: 2).pluck(:valor).sum )
      @dados.merge!( creditos_03:  creditos.where(forma_de_pagamento_id: 3).pluck(:valor).sum + cred_cli.where(forma_de_pagamento_id: 3).pluck(:valor).sum )
      @dados.merge!( creditos_04:  creditos.where(forma_de_pagamento_id: 4).pluck(:valor).sum + cred_cli.where(forma_de_pagamento_id: 4).pluck(:valor).sum )
      @dados.merge!( creditos_05:  creditos.where(forma_de_pagamento_id: 5).pluck(:valor).sum + clientes)
      @dados.merge!( creditos_06:  creditos.where(forma_de_pagamento_id: 6).pluck(:valor).sum + cred_cli.where(forma_de_pagamento_id: 6).pluck(:valor).sum )
      @dados.merge!( creditos_99:  creditos.where(forma_de_pagamento_id: [1,2,3,4,5,6,10]).pluck(:valor).sum + clientes +  cred_cli.where(forma_de_pagamento_id: [1,2,3,4,10,6]).pluck(:valor).sum)
      
      @dados.merge!( debitos_07:   debitos.where(forma_de_pagamento_id: 7).pluck(:valor).sum  )
      @dados.merge!( debitos_08:   debitos.where(forma_de_pagamento_id: 8).pluck(:valor).sum  )
      @dados.merge!( debitos_09:   debitos.where(forma_de_pagamento_id: 9).pluck(:valor).sum  )
      @dados.merge!( debitos_99:   @despesas.where(forma_de_pagamento_id: [7,8,9]).pluck(:valor).sum )
      render layout: 'print4'
    end
  end

  def extrato_por_funcionario
    @dados = []
    if request.post?
      @funcionarios = Usuario.where('percentual > 0').order(:id)
      
      @desconto_total = 0
      @funcionarios.each do |func|
        valor      = comissao = adiantamento = conta_corrente = 0
        descontado = x        = []
        OSS.joins(:ordem_servico).where("ordem_servicos.data::date between ? and ? and funcionario_id = ?", params[:data_i].to_date, params[:data_f].to_date, func.id).order(comissao: :desc, id: :asc).each do |oss|
          desconto         = (descontado.include?(oss.ordem_servico_id) ? 0 : (oss.valor >= 20 ? 2 : 1))
          descontado      << oss.ordem_servico_id
          valor           += oss.valor
          comissao        += ((oss.valor - desconto) * (oss.comissao || func.comissao).to_f / 100)
          @desconto_total += desconto
          x << { func: func.id, desconto: desconto, valor: oss.valor, comissao: ((oss.valor - desconto) * (oss.comissao || func.comissao).to_f / 100) }
        end
        adiantamento   += ContaCorrente.where("forma_de_pagamento_id = 8 and data::date between ? and ? and classe_type = 'Usuario' and classe_id = ?", params[:data_i].to_date, params[:data_f].to_date, func.id).pluck(:valor).sum
        
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

  def extrato_cartoes
    if params[:data].present?
      @contas = ContaCorrente.where(forma_de_pagamento_id: 4, data: params[:data].to_date).includes(:classe,:forma_de_pagamento,:ordem_servico).order(:id)
    end
  end

  def detalhar_extrato
    @funcionario = Usuario.where(id: params[:id]).first
    @dados = []

    #valor = comissao = adiantamento = conta_corrente = 0
    descontado = []
    OSS.joins(:ordem_servico).where("ordem_servicos.data::date between ? and ? and funcionario_id = ?", params[:data_i].to_date, params[:data_f].to_date, @funcionario.id).order(comissao: :desc, id: :asc).each do |oss|
      desconto      = (descontado.include?(oss.ordem_servico_id) ? 0 : (oss.valor >= 20 ? 2 : 1))
      descontado   << oss.ordem_servico_id
        
      valor        = oss.valor
      comissao     = ((oss.valor - desconto) * (oss.comissao || @funcionario.comissao).to_f / 100)
   
      @dados << { id: oss.ordem_servico_id, 
                  numero:       oss.ordem_servico.numero,
                  cliente:      oss.ordem_servico.cliente.nome,
                  servico:      (oss.servico.tipo_servico.descricao.to_s + " - " + oss.servico.descricao.to_s),
                  data:         oss.ordem_servico.created_at,
                  valor:        valor,
                  comissao:     comissao,
                  saldo:        comissao }
    end
    @adiantamentos = ContaCorrente.where("forma_de_pagamento_id = 8 and data::date between ? and ? and classe_type = 'Usuario' and classe_id = ?", params[:data_i].to_date, params[:data_f].to_date, @funcionario.id)
  end

  def pagamento_funcionario
    if request.post?
      @funcionario = Usuario.find(params[:funcionario_id])

      @lancamentos  = ContaCorrente.where("tipo_lancamento_id = 2 and data::date between ? and ? and classe_type = 'Usuario' and classe_id = ?", params[:data_ini].to_date, params[:data_fim].to_date, @funcionario.id).order(:id)
    end
    if params[:imprimir].present?
      render layout: 'print4'
    end
  end
end
