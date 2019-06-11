class UsersController < ApplicationController

  get '/signup' do
    erb '/users/signup'
  end

  # post "/signup" do
  #   if params[:username] == "" || params[:password] == ""
  #     redirect to '/failure'
  #   else
  #     user = User.create(username: params[:username], password: params[:password])
  #     session[:user_id] = user.id
  #     redirect to '/login'
  #   end
  # end
  #
  # get '/login' do
  #   erb :login
  # end
  #
  # post "/login" do
  #   user = User.find_by(:username => params[:username])
  #   if user && user.authenticate(params[:password])
  #     session[:user_id] = user.id
  #     redirect to "/tweets/new"
  #   else
  #     redirect "/failure"
  #   end
  # end
  #
  # get "/logout" do
  #   session.clear
  #   redirect "/login"
  # end
  #
  # helpers do
  #   def logged_in?
  #     !!session[:user_id]
  #   end
  #
  #   def current_user
  #     User.find(session[:user_id])
  #   end
  # end

end
