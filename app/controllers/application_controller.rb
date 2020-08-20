
require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

  end

  get '/articles' do
    @articles = Article.all 
    erb :index
  end 

  get '/articles/new' do
    erb :new
  end 

  post '/articles' do
    new_article = Article.create(params)
    redirect "/articles/#{new_article.id}"
  end 

  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end 

  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    @article = Article.find_by(id: params[:id])
    @article.update(title: params[:title], content: params[:content])
    erb :show
  end 

  delete '/articles/:id' do 
    @article = Article.find_by_id(params[:id])
    @article.delete
    redirect '/articles'
  end 
  
end
