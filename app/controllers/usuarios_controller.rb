class UsuariosController < ApplicationController
  before_action :set_usuario, only: [:lock_unlock, :resetar_senha, :show, :editar_permissoes, :atualizar_permissoes]
  before_action :authenticate_usuario!, except: :atualizar_hora

  def index
    #relatorio_por_permissao
    @usuarios = Usuario.where('id > 1').order(:id)
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

  def show
  end

  def editar_permissoes
  end

  # Atualiza Permissões do usuario :: Danilo J
  def atualizar_permissoes
    params[:usuario]         ||= {}
    params[:usuario][:roles] ||= []
    if @usuario.update(usuario_params)
      redirect_to usuarios_path, notice: t(:updated, name: "Usuário " + @usuario.login)
    end
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
      params.require(:usuario).permit(:email, :celular, :telefone, :nome, :custo_mensal, :sexo, :profissao, :cep , :endereco, :numero, :complemento, :bairro, :cidade, :estado, :fone, :fone2, :nascimento, :roles => [])
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
