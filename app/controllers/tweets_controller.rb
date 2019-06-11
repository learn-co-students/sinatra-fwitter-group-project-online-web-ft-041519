class TweetsController < ApplicationController

  get '/tweets' do
    if is_logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end
  
  get '/tweets/new' do
    if is_logged_in?
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end
  
  post '/tweets' do
    if !params[:content].empty?
      Tweet.create(content: params[:content], user_id: session[:user_id])
      redirect to '/tweets'
    else
      redirect to '/tweets/new'
    end
  end
  
  get '/tweets/:id' do
    if is_logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end
  
  get '/tweets/:id/edit' do
    if !is_logged_in?
      redirect to '/login'
    else
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/edit_tweet'
    end
  end
  
  patch '/tweets/:id' do
    tweet = Tweet.find_by(id: params[:id])
    
    if !params[:content].empty?
      tweet.update(content: params[:content])
      redirect to '/tweets'
    else 
      redirect to "tweets/#{params[:id]}/edit"
    end
  end
  
  delete '/tweets/:id/delete' do
    if !is_logged_in?
      redirect to '/login'
    end
    
    @tweet = Tweet.find_by(id: params[:id])
    
    if @tweet.user == current_user
      @tweet.destroy
      redirect to '/tweets'
    else
      redirect to '/tweets'
    end
  end

end
