class RelatoriosController < ApplicationController
  skip_authorize_resource
  
  def call_authorize_ability  
    authorize_ability(:relatorios)
  end
  
  def index
  end

  def movimento_de_caixa
    if request.post?
      @dados = {}
      @dados.merge!( debitos_01:  ContaCorrente.debitos.dia(params[:data])  )
      @dados.merge!( debitos_02:  ContaCorrente.debitos.dia(params[:data])  )
      @dados.merge!( debitos_03:  ContaCorrente.debitos.dia(params[:data])  )
      @dados.merge!( debitos_04:  ContaCorrente.debitos.dia(params[:data])  )
      @dados.merge!( debitos_05:  ContaCorrente.debitos.dia(params[:data])  )
      @dados.merge!( debitos_06:  ContaCorrente.debitos.dia(params[:data])  )
      @dados.merge!( debitos_07:  ContaCorrente.debitos.dia(params[:data])  )
      @dados.merge!( debitos_99:  ContaCorrente.debitos.dia(params[:data])  )
      @dados.merge!( creditos_01: ContaCorrente.creditos.dia(params[:data]) )
      @dados.merge!( creditos_02: ContaCorrente.creditos.dia(params[:data]) )
      @dados.merge!( creditos_03: ContaCorrente.creditos.dia(params[:data]) )
      @dados.merge!( creditos_99: ContaCorrente.creditos.dia(params[:data]) )
    end
  end
end
