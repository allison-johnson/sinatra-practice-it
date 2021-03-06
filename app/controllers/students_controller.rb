require 'rack-flash'
require 'pry'

class StudentsController < ApplicationController
  enable :sessions
  use Rack::Flash 

  #new action
  get '/students/new' do
    redirect_if_not_logged_in 
    set_teacher(session) 
    @field_values = {}
    erb :'students/new'
  end #action

  #show action 
  get '/students/:id' do
    redirect_if_not_logged_in 
    if !set_student 
      redirect '/failure'
    elsif authorized?(@student.teacher, "username")  
      @name = "#{@student.first_name.upcase} #{@student.last_name.upcase}"
      @grade = @student.grade
      @student_questions = @student.questions
      @questions = Question.all
      erb :'students/show'
    else
      redirect "/teachers/#{session[:id]}"
    end
  end

  #edit action 
  get '/students/:id/edit' do 
    redirect_if_not_logged_in 
    if !set_student
      redirect '/failure'
    elsif authorized?(@student.teacher, "username")
      @field_values = {}
      erb :'students/edit'
    else
      redirect '/failure'
    end #if
  end #action

  #create action 
  post '/students' do
    set_teacher(session)
    student = Student.new(params)
    if Student.in_database?(student)
      flash[:message] = "Whoops, looks like that student is already in our system!"
      @field_values = {}
      erb :'students/new'
    elsif !student.save
      flash[:message] = student.errors.full_messages.join(", ")
      @field_values = params
      erb :'students/new'
    else
      @teacher.students << student 
      @teacher.save 
      redirect "/teachers/#{@teacher.id}"
    end #if
  end #action

  #update action
  patch '/students/:id' do
    set_student
    if !@student.update(first_name: params[:first_name], last_name: params[:last_name], grade: params[:grade])
      flash[:message] = @student.errors.full_messages.join(", ")
      @field_values = params
      erb :'students/edit'
    else
      redirect "/students/#{@student.id}"
    end #if
  end #action

  #update action (for a student's questions)
  patch '/students/:id/update-questions' do
    set_student 
    @student.questions.clear 
    if params[:questions]
      params[:questions].each do |question_id|
        Question.find_by(id: question_id).students << @student 
        @student.save 
      end #do
    end #if
    redirect "/students/#{@student.id}"
  end #action 

  #delete action
  delete '/students/:id' do
    set_student 
    if authorized?(@student.teacher, "username")
      Student.delete(params[:id])
      redirect "/teachers/#{session[:id]}"
    else
      erb :'failure'
    end #if
  end #delete

end #class