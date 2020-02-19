require 'rack-flash'

class TeachersController < ApplicationController
  enable :sessions
  use Rack::Flash 
  
  #show (read) action
  get '/teachers/:id' do
    redirect_if_not_logged_in
    set_teacher 
    if authorized?(@teacher)
      @owned_questions = Question.my_questions(params[:id])
      @others_questions = Question.other_questions(params[:id])
      @topics = Topic.all
      erb :'teachers/show'
    else
      set_teacher(session)
      erb :'failure'
    end #if
  end #action 

  #edit action
  get '/teachers/:id/edit' do
    if set_teacher && authorized?(@teacher)
      @field_values = {first_name: @teacher.first_name, last_name: @teacher.last_name, username: @teacher.username} 
      erb :'teachers/edit'
    elsif logged_in?
      set_teacher(session)
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
      @field_values = {}
      erb :'teachers/new'
    end #if
  end #action

  #create action
  post '/teachers' do 
    if params[:teacher][:password] != params[:password][:confirm]
      flash[:message] = "Whoops - password confirmation unsuccessful!"
      @field_values = params[:teacher]
      erb :'teachers/new'
    else #password confirmation is valid
      teacher = Teacher.new(params[:teacher])
      if !teacher.save 
        flash[:message] = teacher.errors.full_messages.join(", ")
        @field_values = params[:teacher]
        erb :'teachers/new'
      else #all validations passed
        redirect '/login'
      end #if able to save
    end #if 
  end #action

  #update action
  patch '/teachers/:id' do
    set_teacher 
    if !@teacher.update(first_name: params[:first_name], last_name: params[:last_name], username: params[:username])
      flash[:message] = @teacher.errors.full_messages.join(", ")
      @field_values = params 
      erb :'teachers/edit'
    else
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
    if @teacher && @teacher.authenticate(params[:password])
      session[:id] = @teacher.id 
      redirect to "/teachers/#{@teacher.id}"
    else
      redirect to '/login'
    end #if
  end #login

  get '/logout' do
    session.clear
    redirect to '/login'
  end #logout

  #delete action 
  delete '/teachers/:id' do
    set_teacher 
    if authorized?(@teacher)
      reassign_owned_questions(@teacher)
      Teacher.delete(params[:id])
      redirect '/'
    else
      set_teacher(session)
      erb :'failure'
    end #if
  end #delete action

  private 
  def reassign_owned_questions(teacher)
    teacher.owned_questions.each do |question|
      teacher == Teacher.all.first ? question.update(owner_id: Teacher.all.last.id) : question.update(owner_id: Teacher.all.first.id)
    end #do
  end #reassign_owned_questions

end #class 