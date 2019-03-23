require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'sinatra/activerecord'
require './models'
require './image_uploader.rb'

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

redirect 'home'
end

post '/signin' do
user = User.find_by(name: params[:name])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
  end
  redirect 'top'
end

get '/signout' do
  session[:user] = nil
  erb :index
end

get '/top' do
    @quests = Quest.all.order("created_at desc")
  erb :top
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
    title2: params[:title2],
    client: params[:client],
    condition: params[:condition],
    member: params[:member],
    details: params[:details],
    details2: params[:details2],
    star: params[:star],
    user_id: current_user.id,
    user_name: current_user.name,
    category_id: category.id,
    img2: params[:img2],
    day: params[:day],
    day2: params[:day2],
    good: 0)

redirect '/home'
end



get '/new/delete/:id' do
  Quest.find(params[:id]).delete
  erb :index
end

get '/chart' do
@categories = Category.all
  if current_user.nil? then
    @quests = Quest.none
  elsif params[:category].nil? then
    @quests = current_user.quests
  else
    @quests = Category.find(params[:category]).quests.where(user_id: current_user.id)
  end

   @exist = current_user.quests.count
   @dones = current_user.quests.where(good: '1').count
   @ws1 =  current_user.quests.where(good: '1', category_id: '1').count
   @ws2 = current_user.quests.where(good: '1', category_id: '2').count
   @teach =  current_user.quests.where(good: '1', category_id: '3').count
   @game = current_user.quests.where(good: '1', category_id: '4').count
   @hukusan = current_user.quests.where(good: '1', category_id: '5').count
   @tech = current_user.quests.where(good: '1', category_id: '6').count
   @radio = current_user.quests.where(good: '1', category_id: '7').count
   @giy = current_user.quests.where(good: '1', category_id: '8').count
   @camp = current_user.quests.where(good: '1', category_id: '9').count
   @ivent = current_user.quests.where(good: '1', category_id: '10').count
   @study = current_user.quests.where(good: '1', category_id: '11').count
   @product = current_user.quests.where(good: '1',category_id: '13').count
   @newss = current_user.quests.where(good: '1',category_id: '14').count
   @book = current_user.quests.where(good: '1',category_id: '15').count
   @english = current_user.quests.where(good: '1',category_id: '16').count
   @movie = current_user.quests.where(good: '1',category_id: '17').count
   @app = current_user.quests.where(good: '1',category_id: '18').count
   @web = current_user.quests.where(good: '1',category_id: '19').count
   @poster = current_user.quests.where(good: '1',category_id: '20').count




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

get '/free' do
  @chats = Chat.all.order("created_at desc")
  erb :free
end

post '/new2' do
  Chat.create({
    chattitle: params[:chattitle],
    chatcoment: params[:chatcoment],
    user_id: current_user.id,
    user_name: current_user.name,
    img3: ""
  })

if params[:img3]
  image_upload(params[:img3])
end

redirect '/free'
end

post '/chatdelete/:id' do
  Chat.find(params[:id]).destroy
  redirect 'free'
end