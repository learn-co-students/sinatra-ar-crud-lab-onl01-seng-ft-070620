
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect '/articles'
  end

  get '/articles/new' do
    erb :new
  end

  get '/articles' do
    @articles = Article.all

    erb :index
  end

  post '/articles' do
    # @article = Article.create(params)
    @article = Article.new(title: params[:title], content: params[:content])
    @article.save

    redirect "/articles/#{@article.id}"
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])

    erb :show
  end

  get 'articles/:id/edit' do
    @article = Article.find_by(params[:id])

    erb :edit
  end

  patch '/articles/:id' do
    @article = Article.find_by(id: params[:id])
    @article.update(params[:article])
    erb :show
  end

  delete 'articles/:id' do
    @article = Article.find_by(id: params[:id])
    @item.delete
    redirect '/articles'
  end
end
