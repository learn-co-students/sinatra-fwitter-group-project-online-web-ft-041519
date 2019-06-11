class TweetsController < ApplicationController

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets' do
    if logged_in?
      @user = User.find_by(session[:user_id])
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    tweet = Tweet.create(content: params["content"])
    @tweets = Tweet.all
    erb :'tweets/index'
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    erb :'tweets/show'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    erb :'tweets/edit'
  end

  post '/tweets/:id/delete' do
    redirect '/tweets'
  end

end
