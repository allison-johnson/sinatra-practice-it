require 'rack-flash'

class TeachersController < ApplicationController
  enable :sessions
  use Rack::Flash 

  #index action
  get '/' do
    erb :'index'
  end #action

  #show action, loads show page for individual teacher
  get '/teachers/:id' do
    @teacher = Teacher.find_by(id: params[:id])
    @others_questions = Question.all.select{|question| question.owner_id != params[:id].to_i}
    @owned_questions = Question.all.select{|question| question.owner_id == params[:id].to_i}
    if logged_in? && @teacher.username == current_user.username
      erb :'teachers/show'
    else
      redirect '/'
    end #if
  end #action 

  #new action
  get '/signup' do
    if logged_in?
      redirect '/'
    else
      erb :'teachers/new'
    end #if
  end #action

  #create action
  post '/teachers' do #If anything was blank, back to signup...
    if params[:first_name] == "" || params[:last_name] == "" || params[:user_name] == "" || params[:password] == ""
      flash[:message] = "Whoops - looks like you forgot to complete a field!"
      redirect '/signup'
    else #If nothing was blank, attempt to create a new Teacher...
      teacher = Teacher.new(first_name: params[:first_name], last_name: params[:last_name], username: params[:username], password: params[:password])
      if teacher.save #All validations passed
        redirect '/login'
      else #Some validation failed, back to signup...
        flash[:message] = "Error!" #How to recognize which field didn't validate correctly?
        redirect '/signup'
      end #if able to save
    end #if
  end #action

  get '/login' do
    if logged_in?
      @teacher = current_user
      redirect to "/#{@teacher.username}/students"
    else
      erb :'teachers/login'
    end
  end #action

  post '/login' do
    @teacher = Teacher.find_by(username: params[:username])

    if @teacher != nil && @teacher.authenticate(params[:password])
      session[:id] = @teacher.id 
      redirect to "/teachers/#{@teacher.id}"
      #redirect to "/#{@teacher.username}/students"
    else
      redirect to '/login'
    end #if
  end #login

  get '/logout' do
    session.clear
    redirect to '/login'
    # if logged_in?
    #   session.clear 
    #   redirect to '/login'
    # else
    #   redirect to '/'
    # end #if
  end #logout



end #class 