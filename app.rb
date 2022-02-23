require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/user'
require_relative './lib/space'

class Makersbnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions, :method_override

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
    @spaces= Space.all
    erb :'spaces/index'
  end

  patch '/spaces/:id' do
    Space.request(id: params['id'], requested_by_id: session[:user_id])
    redirect '/spaces/index'
  end

  post '/spaces/:id' do
    Space.confirm_request(id: params['id'])
    redirect '/spaces/index'
  end

  get '/spaces/requests' do
   
    @requests_made = Space.requests_made(requested_by_id: session[:user_id])
    @requests_to_confirm = Space.requests_to_confirm(user_id: session[:user_id])
    erb :'spaces/requests'
  end


  post '/spaces/availability' do
    session[:available_from] = params['available from']
    session[:available_to] = params['available to']
    # @spaces = Space.find_by(available_from: session[:available_from], available_to: session[:available_to])
    redirect '/spaces/available'
  end

  get '/spaces/available' do
    # session[:available_from] = params['available from']
    # session[:available_to] = params['available to']
    @spaces = Space.find_by(available_from: session[:available_from], available_to: session[:available_to])
    erb :'spaces/available'
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
get '/sessions/logout' do
    session.clear
    redirect '/'
  end

  run! if app_file == $0
end