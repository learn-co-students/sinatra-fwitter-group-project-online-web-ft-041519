class TweetsController < ApplicationController

  get '/tweets' do
    if is_logged_in?
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end
  
  get '/tweets/new' do
    #erb :'tweets/new'
  end
  
  post '/tweets' do
    
  end
  
  get '/tweets/:id' do
    #erb :'tweets/show'
  end
  
  get '/tweets/:id/edit' do
  
  end
  
  patch '/tweets/:id' do
    
  end
  
  delete '/tweets/:id' do
    
  end

end
