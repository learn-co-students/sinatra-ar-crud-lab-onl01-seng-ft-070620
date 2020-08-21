
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
      @article = Article.create(params)
      redirect "/articles/#{Article.last.id}"
  end

  get '/articles' do
      @articles = Article.all
      erb :index
  end

  get '/articles/:id' do
      @article = Article.find(params[:id])
      erb :show
  end

  get '/articles/:id/edit' do
      @article = Article.find_by(params)
      erb :edit
  end

  patch '/articles/:id' do
    @article = Article.find_by(id: params[:id])
    @article.update(params['article'])
    erb :show
  end

  delete '/articles/:id' do
    article = Article.find_by(id: params[:id])
    article.delete
    redirect '/index'
  end

end
