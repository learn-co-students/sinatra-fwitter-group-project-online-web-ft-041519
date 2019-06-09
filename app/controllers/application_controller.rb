require './config/environment'

class ApplicationController < Sinatra::Base
  
  enable :sessions
  configure do
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

   get '/' do
    erb :index
  end
  
  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    end

    erb :"/users/create_user"
  end
  
  post '/signup' do
    if (params[:username]).empty? || (params[:email]).empty? || (params[:password]).empty?
      redirect to '/signup'
    end


    user = User.create(:username => params["username"], :email => params["email"], :password => params["password"])
    session[:user_id] = user.id

    redirect to '/tweets'
  end
  
   get '/login' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    end
      erb :"/users/login"
    end 

  post "/login" do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    @tweets = Tweet.all
    @user = Helpers.current_user(session)
    erb :"/tweets/tweets"
  end
  
  get '/logout' do
    if Helpers.is_logged_in?(session)
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/tweets/new' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    erb :"/tweets/new"
  end

  post '/tweets' do 
    user = Helpers.current_user(session)
    if params["content"].empty?
      redirect to '/tweets/new'
    end
    tweet = Tweet.create(:content => params[:content], :user_id => user.id)

    redirect to '/tweets'
  end 
  
  get '/tweets/:id' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    erb :"tweets/show_tweet"
  end

  get '/tweets/:id/edit' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    if Helpers.current_user(session).id != @tweet.user_id
      redirect to '/tweets'
    end
    erb :"tweets/edit_tweet"
  end

  patch '/tweets/:id' do 
    tweet = Tweet.find(params[:id])
    if params[:content].empty?
      redirect to "/tweets/#{params[:id]}/edit"
    end
    tweet.update(:content => params[:content])
    tweet.save

    redirect to "/tweets/#{tweet.id}"
  end
  
  delete '/tweets/:id/delete' do 
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    if Helpers.current_user(session).id != @tweet.user_id
      redirect to '/tweets'
    else
      @tweet.delete
      redirect to '/tweets'
    end 
  end 

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end


end
