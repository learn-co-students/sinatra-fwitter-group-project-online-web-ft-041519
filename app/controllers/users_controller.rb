class UsersController < ApplicationController

  get '/signup' do
    if is_logged_in?
      redirect to '/tweets'
    else
      erb :'users/create_user'
    end
  end
  
  post '/signup' do
    params.each do |label, value|
      if value.empty?
        redirect to '/signup'
      end
    end
    
    user = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect to '/tweets'
  end
  
  get '/users/:slug' do
    erb :'users/show'
  end
  
  get '/login' do
    if is_logged_in?
      redirect to '/tweets'
    else
      erb :'users/login'
    end
  end
  
  post '/login' do
    #binding.pry
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end
  
  get '/logout' do
    #if logged_in? session.clear or session.destroy, redirect to '/login'
    #else redirect '/'
  end
  

end
