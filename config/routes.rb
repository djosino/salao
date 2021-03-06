Salao::Application.routes.draw do

  resources :caixas do
    member do
      get :fechar
    end
  end

  resources :conta_correntes do
    collection do 
      post :pagamento_debito, :lancar_pagamento
      get  "pagamento_debito/:cliente_id" => "conta_correntes#pagamento_debito", as: :pagamento_debitos
    end
  end

  resources :tipo_servicos

  resources :forma_de_pagamentos, except: :destroy

  resources :ordem_servicos do
    member do
      post :adicionar_servico,    :pagamento
      get  :finalizar, :cancelar, :pagamento
      delete :destroy_oss
    end
  end

  resources :clientes, except: :destroy do
    collection do
      get :relatorio
    end
  end

  resources :produtos, except: :destroy

  resources :servicos, except: :destroy do
    resources :ordem_servicos, only: :destroy
  end

  resources :relatorios, only: :index do 
    collection do
      get  :movimento_de_caixa, :extrato_por_funcionario, :pagamento_funcionario, :detalhar_extrato, :extrato_cartoes
      post :movimento_de_caixa, :extrato_por_funcionario, :pagamento_funcionario, :extrato_cartoes
    end
  end


  # root_url
  unauthenticated do
    devise_scope :usuario do
      root to: 'devise/sessions#new', :as => "unauthenticated"
    end
  end
  root "ordem_servicos#index"

  devise_for :usuarios 
  as :usuarios do
    get 'usuarios'                         => 'usuarios#index',               as: :usuarios
    get 'usuarios/:id'                     => 'usuarios#show',                as: :usuario
    get 'ferramentas'                      => 'usuarios#ferramentas',         as: :ferramentas_usuarios
    get 'usuarios/:id/resetar_senha'       => 'usuarios#resetar_senha',       as: :resetar_senha_usuario      #member
    get 'usuarios/:id/lock_unlock'         => 'usuarios#lock_unlock',         as: :lock_unlock_usuario        #member
    get 'usuarios/:id/editar_permissoes'   => 'usuarios#editar_permissoes',   as: :editar_permissoes_usuario  #member
    #get 'usuarios/sign_up'                 => 'devise/registrations#new',     as: :new_usuario_registration
    #get 'usuarios/:id/sign_in_with'        => 'devise/sessions#sign_in_with', as: :sign_in_with_usuarios_sessions

    patch 'usuarios/update_account/:id', to: 'devise/registrations#update_account', as: :update_account_user_registration
    get   'usuarios/:id/edit_account',   to: 'devise/registrations#edit_account',   as: :edit_account_user_registration
    patch 'usuarios/:id/atualizar_permissoes' => 'usuarios#atualizar_permissoes', as: :atualizar_permissoes_usuario #member
  end

  namespace :dynamic_select do 
    get ':servico_id/servicos',                    to: 'servicos#index',             as: 'servicos'
    get ':tipo_lancamento_id/forma_de_pagamentos', to: 'forma_de_pagamentos#index',  as: 'forma_de_pagamentos'
    get ':funcionario_id/usuarios',                to: 'usuarios#index',             as: 'usuarios'
  end


  #namespace :dynamic_select do
  #  get ':tipo_id/livros', to: 'lotes#livros', as: 'livros'
  #  get ':uf_id/cidades',  to: 'cidades#index', as: 'cidades'
  #end
end
