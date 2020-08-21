
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles' do
    @articles = Article.all
    erb :'../views/index'
  end

  get '/articles/new' do
    erb :new
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :'../views/show'
  end

  post '/articles' do
    @article = Article.new(title: params[:article_title], content: params[:article_content])
    @article.save
    
    redirect "/articles/#{@article.id}"
  end

  get '/articles/:id/edit' do 
    @article = Article.find(params[:id])
    erb :'../views/edit'
  end

  patch '/articles/:id' do
    @article = Article.find(params[:id])
    @article.update(params[:article])
    redirect "/articles/#{@article.id}"
  end

  delete '/articles/:id' do
    Article.destroy(params[:id])
    redirect "/articles"
  end
end
