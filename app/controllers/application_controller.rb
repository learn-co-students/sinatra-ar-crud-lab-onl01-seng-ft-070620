
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

# read - grabs all the articles and renders the index.erb view
  get '/articles' do
    @articles = Article.all
    erb :index
  end

# create - form will submit a POST request to /articles
  get '/articles/new' do
    erb :new
  end

# create - create a new article using the form info in the params hash, then redirects to that new article's show page
  post '/articles' do
    a = Article.create(title: params[:title], content: params[:content])
    redirect "/articles/#{a.id}"
  end

# read - grab the articles with the specified id and then render the show.erb view
  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

# update - render edit.erb so user update the specific article
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

# update - finds the proper instance and updates it
  patch '/articles/:id' do
    a = Article.find(params[:id])
    a.update(title: params[:title], content: params[:content])
    redirect "/articles/#{a.id}"
  end

# delete - deletes the specific article
  delete '/articles/:id' do
    a = Article.find(params[:id])
    a.destroy
  end

end
