require 'rack-flash'

class QuestionsController < ApplicationController
  enable :sessions
  use Rack::Flash 

  #Show a all of a teacher's questions
  get '/:username/questions' do
    #binding.pry 
    if logged_in?
      #@teacher = current_user
      @teacher = Teacher.find_by(username: params[:username]) #also need to make sure that teacher is currently logged in...
      @questions = Question.all
      erb :'questions/index'
    else
      redirect '/'
    end #if
  end #action

  #new action
  get '/questions/new' do
    if logged_in?
      @teacher = Teacher.find_by(id: session[:id]) #This is not actually used, as the question gets created for EVERYONE
      erb :'questions/new'
    else
      redirect '/login'
    end #if
  end #action

  #create action
  post '/questions' do
    if params[:prompt] == "" || params[:difficulty] == "" 
      #flash[:message] = "Whoops - looks like you forgot to complete a field!"
      redirect '/questions/new'
    else #If nothing was blank, attempt to create a new Question...
      question = Question.new(prompt: params[:prompt], difficulty: params[:difficulty])
      if question.save #All validations passed
        #Associate question with all checked topic boxes
        redirect '/'
      else #Some validation failed, back to signup...
        #flash[:message] = "Error!" #How to recognize which field didn't validate correctly?
        redirect '/questions/new'
      end #if able to save
    end #if
  end #action

end #class
