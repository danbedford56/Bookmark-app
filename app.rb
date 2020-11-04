require 'sinatra/base'
require 'sinatra/flash'
require 'uri'
require_relative 'lib/bookmark_manager'
require_relative 'lib/database_connection'
require_relative 'lib/database_connection_setup'

class Bookmark_App < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

  get '/' do
    erb :index
  end

  post '/bookmarks' do
    session[:name] = params[:username]
    redirect '/bookmarks'
  end

  get '/bookmarks' do
    @name = session[:name]
    @bookmarks = Bookmark_Manager.all
    erb :bookmarks
  end

  post '/new' do
    if params[:url] =~ /\A#{URI::regexp}\z/
      Bookmark_Manager.add(params[:title], params[:url])
      redirect '/bookmarks'
    else
      flash[:notice] = 'This URL is not valid.'
      redirect '/bookmarks/new'
    end
  end

  get '/bookmarks/new' do
    erb :new
  end

  delete '/bookmarks/:id' do
    Bookmark_Manager.delete(params['id'])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark_id = params[:id]
    erb :edit
  end

  patch '/bookmarks/:id' do
    Bookmark_Manager.update(id: params[:id], title: params[:title], url: params[:url])

    redirect '/bookmarks'
  end

  run! if app_file == $0
end