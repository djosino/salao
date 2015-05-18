Salao::Application.routes.draw do

  # root_url
  authenticated :usuario do
    root "usuarios#index"
  end
  unauthenticated do
    devise_scope :usuario do
      root to: 'devise/sessions#new', :as => "unauthenticated"
    end
  end

  devise_for :usuarios 
  as :usuarios do
    get 'usuarios/atualizar_hora'          => 'usuarios#atualizar_hora',         as: :atualizar_hora_usuarios
    get 'ferramentas'                      => 'usuarios#ferramentas',         as: :ferramentas_usuarios
    get 'usuarios/:id/resetar_senha'       => 'usuarios#resetar_senha',       as: :resetar_senha_usuario      #member
    get 'usuarios/:id/lock_unlock'         => 'usuarios#lock_unlock',         as: :lock_unlock_usuario        #member
    get 'usuarios/sign_up/:eid/:etype'     => 'devise/registrations#new',     as: :new_usuario_entidade_registration
    get 'usuarios/:id/sign_in_with'        => 'devise/sessions#sign_in_with', as: :sign_in_with_usuarios_sessions

    patch 'usuarios/update_account/:id', to: 'devise/registrations#update_account', as: :update_account_user_registration
    get   'usuarios/:id/edit_account',   to: 'devise/registrations#edit_account',   as: :edit_account_user_registration
  end

  #namespace :dynamic_select do
  #  get ':tipo_id/livros', to: 'lotes#livros', as: 'livros'
  #  get ':uf_id/cidades',  to: 'cidades#index', as: 'cidades'
  #end
end
