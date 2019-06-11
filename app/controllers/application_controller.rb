require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :home
  end

  helpers do
    def current_user
      if is_logged_in?
        @current_user = User.find_by(id: session[:user_id])
      end
      @current_user
    end
  
    def is_logged_in?
      !!session[:user_id]
    end
  end
  
end
