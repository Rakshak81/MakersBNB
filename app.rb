require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/user'

class Makersbnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  get '/' do
    erb :index
  end

  post '/signup' do
    @user = User.create(email: params['email'], username: params['username'], password: params['password'])
    session[:user_id] = @user.id
    session[:user_name] = @user.username
    redirect '/spaces/index'
  end

  get '/spaces/index' do
    erb :'spaces/index'
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions/confirm' do

    @user = User.identify(username: params['username'], password: params['password'])
   if @user 
    session[:user_id] = @user.id
    session[:username] = @user.username
      redirect '/spaces/index'
   else
    redirect '/'
   end
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

post '/spaces/new' do
  user = session[:user_id]
  @space = Space.create(name: params['name'], description: params['description'], price: params['price'], start_date: params['start_date'], end_date: params['end_date'], user_id: user)
  redirect '/spaces/index'
end
# get '/spaces' do
#     erb :spaces
#   end

  run! if app_file == $0
end