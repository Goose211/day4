require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'sinatra/activerecord'
require './models'

enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user])
  end
end


get '/' do
  erb :index
end

get '/signup' do
  erb :sign_up
end

post '/signup' do
  @user = User.create(name:params[:name],password:params[:password],password_confirmation:params[:password_confirmation])

if @user.persisted?
  session[:user] = @user.id
end

redirect '/'
end

post '/signin' do
user = User.find_by(name: params[:name])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
  end
  redirect '/'
end

get '/signout' do
  session[:user] = nil
  redirect '/'
end

#homeにいく。
get '/home' do
  @categories = Category.all
  if current_user.nil? then
    @quests = Quest.none
  elsif params[:category].nil? then
    @quests = current_user.quests
  else
    @quests = Category.find(params[:category]).quests.where(user_id: current_user.id)
  end
  erb :home
end

#投稿のフォームにいく。
get '/actnew' do
  erb :act_new
end

post '/new' do
  category = Category.find(params[:category])
  Quest.create(
    title: params[:title],
    client: params[:client],
    condition: params[:condition],
    member: params[:member],
    details: params[:details],
    star: params[:star],
    user_id: current_user.id,
    user_name: current_user.name,
    category_id: category.id,
    good: 0)

redirect '/home'
end


get '/new/delete/:id' do
  Quest.find(params[:id]).delete
  redirect '/home'
end

get '/chart' do
  erb :chart
end

post '/quests/:id/done' do
  quest = Quest.find(params[:id])
  quest.completed = true
  quest.save

   quest = Quest.find(params[:id])
  good = quest.good
  quest.update({
    good: good + 1
  })

  redirect '/home'
end

get '/category/:id' do #カテゴリーごとに表示するget
  @categories = Category.all
  @category = Category.find(params[:id])
  @category_name = @category.categoname
  @quests = @category.quests
  erb :home
end

get '/quests/done' do
  @categories = Category.all
  @quests = current_user.quests.where(completed: true)
  erb :home
end