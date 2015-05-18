class UsuariosController < ApplicationController
  before_action :set_usuario, only: [:lock_unlock, :resetar_senha]
  before_action :authenticate_usuario!, except: :atualizar_hora

  def index
    relatorio_por_permissao
    @usuarios = Usuario.order(:email)
    @pontos   = current_usuario.pontos.dia_atual.order(:id)
  end

  # Bloqueia ou Desbloqueia Usuario
  def lock_unlock
    @usuario.lock_unlock!
    redirect_to :back, notice: t(:updated, name: "Usuário " + @usuario.email)
  end

  # Resetar senha de usuarios
  # * Padrão 123456
  def resetar_senha
    @usuario.password = @usuario.password_confirmation = '123456'
    @usuario.save
    redirect_to :back, notice: t(:updated, name: "Usuário " + @usuario.email)
  end

  def ferramentas
  end

  def selecionar 
    if current_usuario.mondrian?
       @clientes = Cliente.all.collect{|c| [c.nome, c.id]}
    else
       self.cliente_session = current_usuario.entidade_id
       redirect_to lotes_path
    end
  end

  def set_cliente
    if current_usuario.mondrian?
       session['cliente_id'] = params[:cliente]
       redirect_to lotes_path
    end
  end

  def rendimento
    @usuarios = Usuario.where("indexador is true or conferente is true", :order => 'email asc' ).to_a.collect{|u| [u.email, u.id]}

    data = Date.today - 25.days
    
    if params[:usuario].present? and !params[:conferencia].present?
       data = params[:data].to_date if params[:data].present?
       
       cond = []
       cond << "tipo = 1"
       if params[:usuario].to_i > 0
          @usuario = Usuario.find(params[:usuario])
          cond[0] += " and usuario_id = ?"
          cond << params[:usuario]
       end
       cond << data
       
       if !params[:data_fim].present?
          cond[0] += " and created_at::date = ?"
       else
          cond[0] += " and created_at::date between ? and ?"
          cond << params[:data_fim].to_date
       end
       @lotes = LogValidacao.all(:select => "lote_id, count(id), max(tipo) as tipo, max(created_at), min(created_at)",
                                 :conditions => cond, 
                                 :group => "lote_id", 
                                 :order => "min")
       
    elsif params[:usuario].present? and params[:conferencia].present?
       data = params[:data].to_date if params[:data].present?

       @usuario = Usuario.find(params[:usuario])
       cond = []
       cond << "usuario_id = ? and tipo = 2"
       cond << params[:usuario]
       cond << data

       if !params[:data_fim].present?
          cond[0] += " and created_at::date = ?"
       else
          cond[0] += " and created_at::date between ? and ?"
          cond << params[:data_fim].to_date
       end

       @lotes = LogValidacao.all(:select => "lote_id, count(id), max(tipo) as tipo, max(created_at), min(created_at)",
                         :conditions => cond,
                         :group => "lote_id",
                         :order => "min")
    elsif params[:conferencia].present?
       cond = []
       cond << "created_at::date > ? and tipo = 2"
       cond << data
       if current_usuario.is?(:gerente) or current_usuario.is?(:master)
          cond[0] += " and usuario_id is not null"
       else
          cond[0] += " and usuario_id = ?"
          cond    << current_usuario.id
       end
       
       @documentos = LogValidacao.all(:select => "usuario_id, count(id), count(distinct(lote_id)) as qtd_lote, max(created_at::date) as att", 
                                   :conditions => cond, 
                                   :group => "created_at::date, usuario_id", 
                                   :order => "att desc, 1 desc")
    else
       cond = []
       cond << "created_at::date > ? and tipo = 1"
       cond << data
       if current_usuario.is?(:gerente) or current_usuario.is?(:master)
          cond[0] += " and usuario_id is not null"
       else
          cond[0] += " and usuario_id = ?"
          cond    << current_usuario.id
       end
       
       @documentos = LogValidacao.all(:select => "usuario_id, count(id), count(distinct(lote_id)) as qtd_lote, max(created_at::date) as att", 
                                   :conditions => cond,
                                   :group => "created_at::date, usuario_id", 
                                   :order => "att desc, 1 desc")
    end
  end

  def consultar
    respond_to do |format|
      format.html { @usuarios = Usuario.where(login: params[:login]) if params[:login].present?  }
      format.json { @usuarios = Usuario.where(locked_at: nil).select(:login).order(:login) }
    end
  end

  def scan
     time = Time.now.strftime("%H_%M_%S")
     `scanimage > /shared/publico/time#{digitalizacao}.pbm`
     `convert /shared/publico/digitalizacao#{time}.pbm /shared/publico/digitalizacao#{time}.pdf`
     `rm -f /shared/publico/digitalizacao#{time}.pbm`
     sleep 3
     redirect_to :back, notice: "Documento salvo em publico/digitalizacao#{time}.pdf"
  end

  def atualizar_hora
     render :text => "Daniel"
     return
     require 'net/telnet'
     msg = ""
     pop = Net::Telnet::new("Host" => '192.168.0.15', "Port" => 2000,  "Telnetmode" => false, "Prompt" => /^\+OK/n)
     pop.cmd("/setarHora/" + Time.now.strftime("%H:%M:%S-%d/%m/%Y")) { |c| msg += c }
   end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usuario
      @usuario = Usuario.find(params[:id])
    end

    def usuario_params
      params.require(:usuario).permit(:email, :celular, :telefone, :nome, :custo_mensal, :roles => [])
    end

    def relatorio_por_permissao
      @retornos  = []
      @relatorio = []
      if current_usuario.is?('empresa_atendente')
        Contato.where("retorno::date = current_date").each do |c|
          if Contato.where("cartorio_id = ? and id > ?", c.cartorio_id, c.id).count == 0
            @retornos << c
          end
        end
      elsif current_usuario.is?('empresa_indexador')
        hoje = Date.today
        for i in (hoje - 7.day)..(hoje)
          total =  LogValidacao.where("created_at::date = ? and tipo = 1 and user_id = ?", i, current_usuario.id).count
          @relatorio << [i.to_s_br, total]
        end
        total =  LogValidacao.where("date_part('month',created_at::date) = ? and date_part('year', created_at::date) = ? and tipo = 1 and user_id = ?", hoje.month, hoje.year, current_usuario.id).count
        @relatorio << ['Mensal', total]
      end
    end
end
