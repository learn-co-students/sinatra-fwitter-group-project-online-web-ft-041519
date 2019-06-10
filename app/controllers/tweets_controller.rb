class TweetsController < ApplicationController
  get '/tweets' do
    redirect '/login' if !logged_in?
    @tweets = current_user.tweets
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    redirect '/login' if !logged_in?
    erb :'tweets/new'
  end

  post '/tweets' do
    redirect '/login' if !logged_in?
    if params[:content] == ""
      redirect to "/tweets/new"
    else
      @tweet = current_user.tweets.build(content: params[:content])
      if @tweet.save
        redirect to "/tweets/#{@tweet.id}"
      else
        redirect to "/tweets/new"
      end
    end
  end

  get '/tweets/:id' do
    redirect '/login' if !logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/show'
   end

  get '/tweets/:id/edit' do
    redirect '/login' if !logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet && @tweet.user == current_user
      erb :'tweets/edit'
    else
      redirect to '/tweets'
    end
  end

  patch '/tweets/:id' do
    redirect '/login' if !logged_in?
    if params[:content] == ""
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        if @tweet.update(content: params[:content])
          redirect to "/tweets/#{@tweet.id}"
        else
          redirect to "/tweets/#{@tweet.id}/edit"
        end
      else
        redirect to '/tweets'
      end
    end
  end

  delete '/tweets/:id/delete' do
    redirect '/login' if !logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet && @tweet.user == current_user
      @tweet.delete
    end
    redirect to '/tweets'
  end
end
