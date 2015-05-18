module ApplicationHelper

  def sortable(column, title = nil, opts = {})
    title ||= model_class.human_attribute_name(column)
    direction = (column.to_s == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}.merge(opts)
  end

  def flash_message(obj = nil)
    msg = ""
    if flash[:notice].present?
      msg ="<div class='alert alert-success'><a data-dismiss='alert' class='close'>×</a> <strong>Informação:</strong> #{flash[:notice]}</div>"
    elsif flash[:alert].present?
      msg ="<div class='alert alert-block'><a data-dismiss='alert' class='close'>×</a> <strong>Alerta:</strong> #{flash[:alert]}</div>"
    elsif flash[:error].present?
      flash[:error].split('<br/>').each do |error|
        msg += "<div class='alert alert-error'><a data-dismiss='alert' class='close'>×</a> <strong>Erros:</strong> #{error}</div>"
      end
    elsif params[:info_mensagem].present?
      msg ="<div class='alert alert-info'><a data-dismiss='alert' class='close'>×</a> <strong>Nota:</strong> #{params[:info_mensagem]}</div>"
    elsif obj and !obj.errors.full_messages.blank?
      obj.errors.full_messages.each do |erro|
        msg += "<div class='alert alert-error'><span class='icon'></span><strong>Erros:</strong> #{erro.to_s.gsub('base','')} </div>"
      end
    end
    flash[:notice] = flash[:alert] = flash[:error] = nil
    return ( render :inline => msg )
  end

  def flash_error(obj = nil)
    msg = ""
    if obj and !obj.errors.full_messages.blank?
       obj.errors.full_messages.each do |erro|
          msg += "<div class='alert alert-error'><span class='icon'></span><strong>Erros:</strong> #{erro.to_s.gsub('base','')} </div>"
       end
    end
    return ( render :inline => msg )
  end
  

  #def image_tag(*args)
  #  if !args.first.match(/missing.png/).nil?
  #    return ''
  #  end
  #  super(*args)
  #end

  def l(*args)
    if args.first.nil?
      return ''
    else
      if args.include?({wday: true})
        I18n.t('.date.abbr_day_names')[args.first.to_date.wday]
      else
        super(*args)
      end
    end
  end

  def cpf_cnpj_formatado(cpf_cnpj = '')
    cpf_cnpj ||= ''
    if cpf_cnpj.size == 11
      Cpf.new(cpf_cnpj).numero
    elsif cpf_cnpj.size == 14
      Cnpj.new(cpf_cnpj).numero
    else
      cpf_cnpj
    end
  end

  def page_navigation_links(pages)
    will_paginate(pages, class:  'pagination', :inner_window => 2, :outer_window => 0, :renderer => BootstrapLinkRenderer, :previous_label => '&larr;'.html_safe, :next_label => '&rarr;'.html_safe)
  end

  def current?(controller_name, action_name, menu)
    retorno  = case menu
            when :principal     then (controller_name == 'usuarios' and action_name == 'index')
            when :ferramenta    then (controller_name == 'usuarios' and action_name == 'ferramentas' ) 
            else
               false
          end

    default = []
    if menu == :principal and !retorno 
       default << current?(controller_name, action_name, :ferramenta)
       default << current?(controller_name, action_name, :emitir_boleto)
       default << current?(controller_name, action_name, :dute)
       default << current?(controller_name, action_name, :gerenciar)
       default << current?(controller_name, action_name, :admin)

       retorno = (default.include?('current') == false)
    end

    return retorno ? 'current' : ''
  end

  def yes_or_no?(value)
    value ? "Sim" : "Não"
  end

  def equipes
    Equipe.all.pluck(:nome, :id)
  end

  def estados
    [["CEARÁ", "CE"], ["ACRE", "AC"], ["ALAGOAS", "AL"], ["AMAPÁ", "AP"], ["AMAZONAS", "AM"], ["BAHIA", "BA"], ["DISTRITO FEDERAL", "DF"], ["ESPIRITO SANTO", "ES"], ["GOIAS", "GO"], ["MARANHÃO", "MA"], ["MATO GROSSO DO SUL", "MS"], ["MATO GROSSO", "MT"], ["MINAS GERAIS", "MG"], ["PARAIBA", "PB"], ["PARANA", "PR"], ["PARA", "PA"], ["PERNAMBUCO", "PE"], ["PIAUI", "PI"], ["RIO DE JANEIRO", "RJ"], ["RIO GRANDE DO NORTE", "RN"], ["RIO GRANDE DO SUL", "RS"], ["RONDÔNIA", "RO"], ["RORAIMA", "RR"], ["SANTA CATARINA", "SC"], ["SAO PAULO", "SP"], ["SERGIPE", "SE"], ["TOCANTINS", "TO"]]
  end

  def meses
    [["Janeiro", 1], ["Fevereiro", 2], ["Março", 3], ["Abril", 4], ["Maio", 5], ["Junho", 6], ["Julho", 7], ["Agosto", 8], ["Setembro", 9], ["Outubro", 10], ["Novembro", 11], ["Dezembro", 12]]
  end

  def mes(value = nil)
    if value
      meses[value-1][0]
    else
      ""
    end
  end

  def anos
    (2013..(Date.today.year)).to_a
  end
  
  def pattern(tipo = nil)
    case tipo
      when :selo     then "[A-Z]{2}[0-9]{6}"
      when :data     then "^[0-9]{2}\/[0-9]{2}\/[0-9]{4}$"
      when :placa    then "[A-Z]{3}\\d{4}"
      when :cep      then "^[0-9]{5}-[0-9]{3}$"
      when :boleto   then "[0-9]{10}"
      when :valor    then "((^[0-9]+$)|(^[0-9]+\\.{1}[0-9]+$))"
      when :numero   then "[0-9]+"
      when :datetime then "^[0-9]{2}\/[0-9]{2}\/[0-9]{4} [0-9]{2}:[0-9]{2}:[0-9]{2}$"

      else 
        "*"
    end
  end

  def placeholder(tipo  = nil)
    case tipo
      when :valor then "99.99"
      else 
        ""
    end
  end

  def image_checkbox(mark = nil)
    if mark
      check_box_tag :show, mark, mark, class: 'checkbox', disabled: true
    else
      check_box_tag :show, nil, nil, class: 'checkbox', disabled: true
    end
  end


  def include_blank
    {include_blank: ' --- Selecione --- '}
  end

  def img_header
    image_path "template/icons/packs/fugue/16x16/ui-list-box-blue.png"
  end
  def img_calc
    image_path "template/icons/packs/fugue/16x16/calculator.png"
  end

  class BootstrapLinkRenderer < ::WillPaginate::ActionView::LinkRenderer
    protected
      def html_container(html)
        tag :div, tag(:ul, html), container_attributes
      end
       
      def page_number(page)
        tag :li, link(page, page, rel: rel_value(page)), class: ('active' if page == current_page)
      end
       
      def gap
        tag :li, link(super, '#'), class: 'disabled'
      end
       
      def previous_or_next_page(page, text, classname)
        tag :li, link(text, page || '#'), class: [classname[0..3], classname, ('disabled' unless page)].join(' ')
      end
  end
end
