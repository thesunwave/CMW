CMW::Application.routes.draw do
  get 'subscriptions/index'

  # переключить локаль
  get '/lang/:locale' => 'api/v1/common_api#switch_locale'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # проверить
      scope '/check' do
        post  'email'       => 'common_api#check_email'
        post  'username'    => 'common_api#check_username'
      end

      # пользователи
      resources :users, except: [:new, :create] do
        # создаст маршруты без параметра :id
        collection do
          get 'settings'  => 'users#settings'
        end
      end

    end   # v1
  end   # api

  # путь / (корень)
  root to: 'root#index'

  # все вьюхи
  scope '/views' do
    # сцена
    get 'index'           => 'root#index'

    # пользователь
    scope '/user' do
      # профиль
      get 'profile'       => 'profile#index'
      # новости
      get 'feed'          => 'feed#index'
      # подписки
      get 'subscriptions' => 'subscriptions#index'
      # работы
      scope '/works' do
        # список
        get '/list'       => 'works#list'
      end
    end
  end
  
  # devise
  devise_for  :users, path: 'auth',
    # переопределение контроллеров
    controllers: { 
      registrations:  'devise/registrations', 
      sessions:       'devise/sessions',
      confirmations:  'devise/confirmations',
      passwords:      'devise/passwords'
    }, 
    # переопределение путей по умолчанию
    path_names: { 
      sign_in:        'login', 
      sign_out:       'logout', 
      confirmation:   'confirm', 
      registration:   'settings' 
    }

end   # CMW::Application.routes.draw