class TweetsController < ApplicationController
  
  get '/tweets' do
    if logged_in?   
      @user = current_user 
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else 
      redirect to '/login'
    end 
  end
  
  get '/tweets/new' do 
    erb :"tweets/new"
  end 

  post '/tweets' do
    if logged_in? 
      @tweet = current_user.tweets.build(params)
      @tweet.save
    else 
      redirect to '/login'
    end 
  end
  
  get '/tweets/:id' do 
  
  end

end
