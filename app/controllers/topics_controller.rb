require 'rack-flash'

class TopicsController < ApplicationController
  enable :sessions
  use Rack::Flash 

  #Show page for a particular topic
  get '/topics/:id' do
    if logged_in?
      @topic = Topic.find_by(id: params[:id])
      @questions = Question.all.select{|question| question.topics.include?(@topic)}
      erb :'topics/show'
    else
      redirect '/'
    end
  end

  #Show all of a teacher's topics
  get '/:username/topics' do
    if logged_in?
      #@teacher = current_user
      @teacher = Teacher.find_by(username: params[:username]) #also need to make sure that teacher is currently logged in...
      @topics = Topic.all
      erb :'topics/index'
    else
      redirect '/'
    end #if
  end #action

  #new action
  get '/topics/new' do
    if logged_in?
      @teacher = Teacher.find_by(id: session[:id]) #This is not actually used, as the question gets created for EVERYONE
      erb :'topics/new'
    else
      redirect '/login'
    end #if
  end #action

  #create action
  post '/topics' do
    if params[:name] == ""
      #flash[:message] = "Whoops - looks like you forgot to complete a field!"
      redirect '/topics/new'
    else #If nothing was blank, attempt to create a new Topic...
      topic = Topic.new(name: params[:name])
      if topic.save #All validations passed
        redirect '/'
      else #Some validation failed, try again...
        #flash[:message] = "Error!" #How to recognize which field didn't validate correctly?
        redirect '/topics/new'
      end #if able to save
    end #if
  end #action

end #class