require 'rack-flash'

class QuestionsController < ApplicationController
  enable :sessions
  use Rack::Flash 

  #new action
  get '/questions/new' do
    if logged_in?
      @topics = Topic.all 
      @teacher = Teacher.find_by(id: session[:id]) #This is not actually used, as the question gets created for EVERYONE
      erb :'questions/new'
    else
      redirect '/login'
    end #if
  end #action

  #Show page for a particular question
  get '/questions/:id' do
    if logged_in?
      @question = Question.find_by(id: params[:id])
      @topics = @question.topics
      @difficulty = @question.difficulty
      @prompt = @question.prompt 
      @owner = Teacher.find_by(id: @question.owner_id) #use this in show page
      erb :'questions/show'
    else
      redirect '/'
    end
  end #action 

  #Edit action
  get '/questions/:id/edit' do
    @question = Question.find_by(id: params[:id])
    if logged_in? && @question.owner_id == session[:id]
      @topics = Topic.all 
      erb :'questions/edit'
    else
      redirect '/'
    end #if
  end #action

  #Show all of a teacher's questions (index page)
  get '/:username/questions' do
    #binding.pry 
    if logged_in? && current_user.username == params[:username]
      #@teacher = current_user
      @teacher = Teacher.find_by(username: params[:username]) #also need to make sure that teacher is currently logged in...
      @questions = Question.all
      erb :'questions/index'
    else
      redirect '/'
    end #if
  end #action

  #create action
  post '/questions' do
    if params[:prompt] == "" || params[:difficulty] == "" 
      #flash[:message] = "Whoops - looks like you forgot to complete a field!"
      redirect '/questions/new'
    else #If nothing was blank, attempt to create a new Question...
      question = Question.new(prompt: params[:prompt], difficulty: params[:difficulty], owner_id: session[:id])
      if question.save #All validations passed, so associate question with selected topics
        topics = params[:topics]
        topics.each do |topic|
          question.topics << Topic.find_by(name: topic)
        end #each
        redirect "/teachers/#{session[:id]}"
      else #Some validation failed, try again...
        #flash[:message] = "Error!" #How to recognize which field didn't validate correctly?
        redirect '/questions/new'
      end #if able to save
    end #if
  end #action

  #update action
  patch '/questions/:id' do
    if params[:prompt] == ""
      redirect "/questions/#{params[:id]}/edit"
    else
      @question = Question.find_by(id: params[:id])
      @question.update(prompt: params[:prompt])
      redirect "/teachers/#{session[:id]}"
    end #if
  end #action

end #class
