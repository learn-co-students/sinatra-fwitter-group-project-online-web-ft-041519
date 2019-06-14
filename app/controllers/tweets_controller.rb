class TweetsController < ApplicationController
  
  get '/tweets' do 
    if logged_in?   
      @user = current_user 
      @tweets = current_user.tweets
      erb :'tweets/tweets'
    else 
      redirect to '/login'
    end 
  end
  
  get '/tweets/new' do 
    erb :"tweets/new"
  end 

  post '/tweets' do 
    redirect to '/login'
  end
  
  get '/tweets/:id' do 
  
  end

end
