require 'rack-flash'

class TeachersController < ApplicationController
  enable :sessions
  use Rack::Flash 

  #show action, loads show page for individual teacher
  get '/teachers/:id' do
    @teacher = Teacher.find_by(id: params[:id])
    @others_questions = Question.all.select{|question| question.owner_id != params[:id].to_i}
    @owned_questions = Question.all.select{|question| question.owner_id == params[:id].to_i}
    if logged_in? && @teacher.username == current_user.username
      @topics = Topic.all
      erb :'teachers/show'
    elsif logged_in? && @teacher.username != current_user.username
      @current_teacher = Teacher.find_by(id: session[:id])
      erb :'failure'
    else
      redirect '/login'
    end #if
  end #action 

  #edit action
  get '/teachers/:id/edit' do
    @teacher = Teacher.find_by(id: params[:id])
    if logged_in? && @teacher && current_user.username == @teacher.username
      erb :'teachers/edit'
    elsif logged_in?
      @current_teacher = Teacher.find_by(id: session[:id])
      erb :'failure'
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
    #binding.pry 
    if params[:first_name] == "" || params[:last_name] == "" || params[:user_name] == "" || params[:password] == ""|| params[:confirm_password] == ""
      flash[:message] = "Whoops - looks like you forgot to complete a field!"
      redirect '/signup'

    elsif params[:password] != params[:confirm_password] #Check to make sure password was confirmed correctly
      flash[:message] = "Whoops - looks like your password confirmation was incorrect!"
      session[:desired_first_name] = params[:first_name] 
      session[:desired_last_name] = params[:last_name] 
      session[:desired_username] = params[:username]
      redirect 'signup'

    else #If nothing was blank, attempt to create a new Teacher...
      teacher = Teacher.new(first_name: params[:first_name], last_name: params[:last_name], username: params[:username], password: params[:password])
      if !teacher.save #Some validation failed
        flash[:message] = "#{teacher.errors.messages.keys.first.to_s} #{teacher.errors.messages.values.first[0]}"
        redirect '/signup'
      else #All validations passed
        redirect '/login'
      end #if able to save

    end #if 
  end #action

  #update action
  patch '/teachers/:id' do
    @teacher = Teacher.find_by(id: params[:id])
    if params[:first_name] == "" || params[:last_name] == "" || params[:username] == ""
      redirect "/teachers/#{params[:id]}/edit"
    else
      @teacher.update(first_name: params[:first_name])
      @teacher.update(last_name: params[:last_name])
      @teacher.update(username: params[:username])
      redirect "/teachers/#{session[:id]}"
    end #if
  end #action

  get '/login' do
    if logged_in?
      @teacher = current_user
      redirect to "/teachers/#{@teacher.id}"
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

  #delete action
  delete '/teachers/:id' do
    @teacher = Teacher.find_by(id: params[:id])
    if logged_in? && @teacher && current_user.username == @teacher.username
      @owned_questions = @teacher.owned_questions 

      #Before deleting teacher, reset owner_id of their owned questions
      @owned_questions.each do |question|
        question.update(owner_id: Teacher.all.first.id) 
        #question.save 
      end #do

      Teacher.delete(params[:id])
      redirect '/'

    elsif logged_in?
      @current_teacher = Teacher.find_by(id: session[:id])
      erb :'failure'
    else
      redirect '/'
    end #if
  end #delete action

end #class 