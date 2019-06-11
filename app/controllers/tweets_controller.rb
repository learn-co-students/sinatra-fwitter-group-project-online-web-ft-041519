class TweetsController < ApplicationController

  get '/tweets/new' do
    erb :new
  end

  post '/tweets' do
    tweet = Tweet.create(content: params["content"])
    tweet.save
    @tweets = Tweet.all
    erb :index
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    erb :show
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    erb :edit
  end

  post '/tweets/:id/delete' do
    erb :tweets
  end

end
