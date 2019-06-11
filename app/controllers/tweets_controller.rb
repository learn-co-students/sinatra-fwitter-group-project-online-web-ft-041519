class TweetsController < ApplicationController

  get '/tweets/new' do
    erb :'tweets/new'
  end

  get '/tweets' do
    binding.pry
    @tweets = Tweet.all
    erb :'tweets/index'
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
