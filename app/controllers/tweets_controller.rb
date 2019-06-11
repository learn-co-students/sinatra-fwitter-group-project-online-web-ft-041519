class TweetsController < ApplicationController

  get '/tweets/new' do
    erb :new
  end

  post '/tweets' do
    @tweet = Tweet.new(content: params["content"])
    erb :tweets
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    erb :show
  end

end
