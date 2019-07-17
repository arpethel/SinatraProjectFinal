class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/images'
    else
      erb :index
    end
  end

  post '/signup' do
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])

    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/signup'
    else
      @user.save
      session[:user_id] = @user.id
      redirect '/images'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/images'
    end
    erb :index
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/images'
    end
    redirect '/login'
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect '/login'
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"users/show"
  end

end
