require 'sinatra/base'
require 'sinatra/reloader'

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
    session[:user_name] = @user.name
    redirect '/spaces'
  end

  get '/spaces' do
    erb :spaces
  end

  run! if app_file == $0
end