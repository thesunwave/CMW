Cmw::Application.routes.draw do
  # переключить локаль
  get '/lang/:locale' => 'api/v1/common_api#switch_locale'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # проверить
      scope '/check' do
        post  'email'       => 'common_api#check_email'
        post  'username'    => 'common_api#check_username'
      end
      # получить
      scope '/get' do
        get   'locale'      => 'common_api#get_locale'
      end

      # список стран
      resources :countries, only: [:index]
      # список городов определенной страны
      resources :cities, only: [:show], param: :country_id

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
    get 'index'     => 'index#index'

    # пользователь
    scope '/user' do
      # профиль
      get 'profile' => 'profile#index'
      # новости
      get 'feed' => 'feed#index'
      # работы
      scope '/works' do
        # список
        get '/list' => 'works#list'
      end
    end
  end
  
  # devise
  devise_for  :users, path: 'auth',
    # переопределение контроллеров
    controllers: { 
      registrations:  'devise/extended_registrations', 
      sessions:       'devise/extended_sessions',
      confirmations:  'devise/extended_confirmations',
      passwords:      'devise/extended_passwords'
    }, 
    # переопределение путей по умолчанию
    path_names: { 
      sign_in:        'login', 
      sign_out:       'logout', 
      confirmation:   'confirm', 
      registration:   'settings' 
    }

end   # Cmw::Application.routes.draw