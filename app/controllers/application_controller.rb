
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

# Read - grabs all the articles and renders the index.erb view
# index.erb
  get '/articles' do
    @articles = Article.all
    erb :index
  end

# Create - form will submit a POST request to /articles
# new.erb
  get '/articles/new' do
    erb :new
  end

# Create - create a new article using the form info in the params hash, then redirects to that new article's show page
  post '/articles' do
    a = Article.create(title: params[:title], content: params[:content])
    redirect "/articles/#{a.id}"
  end

# Read - grab the articles with the specified id and then render the show.erb view
# show.erb
  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

# Update - render edit.erb so user update the specific article
# edit.erb
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

# Update - finds the proper instance and updates it
  patch '/articles/:id' do
    a = Article.find(params[:id])
    a.update(title: params[:title], content: params[:content])
    redirect "/articles/#{a.id}"
  end

# Delete - deletes the specific article
  delete '/articles/:id' do
    a = Article.find(params[:id])
    a.destroy
  end

end
