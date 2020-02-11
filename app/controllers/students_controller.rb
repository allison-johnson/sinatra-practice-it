require 'rack-flash'

class StudentsController < ApplicationController
  enable :sessions
  use Rack::Flash 

  #Show page for a particular student
  get '/students/:id' do
    if logged_in?
      @student = Student.find_by(id: params[:id])
      @name = "#{@student.first_name.upcase} #{@student.last_name.upcase}"
      @grade = @student.grade
      @questions = @student.questions
      erb :'students/show'
    else
      redirect '/'
    end
  end

  #new action
  get '/students/new' do
    if logged_in?
      @teacher = Teacher.find_by(id: session[:id])
      erb :'students/new'
    else
      redirect '/login'
    end #if
  end #action

  #Show a all of a teacher's students (index action)
  get '/:username/students' do
    #binding.pry 
    if logged_in?
      #@teacher = current_user
      @teacher = Teacher.find_by(username: params[:username]) #also need to make sure that teacher is currently logged in...
      @students = @teacher.students
      erb :'students/index'
    else
      redirect '/'
    end #if
  end #action

  #create action
  post '/students' do
    if params[:first_name] == "" || params[:last_name] == "" || params[:grade] == "" 
      #flash[:message] = "Whoops - looks like you forgot to complete a field!"
      binding.pry 
      redirect '/students/new'
    else #If nothing was blank, attempt to create a new Student...
      student = Student.new(first_name: params[:first_name], last_name: params[:last_name], grade: params[:grade].to_i)
      if student.save #All validations passed
        @teacher = Teacher.find_by(id: session[:id])
        @teacher.students << student 
        @teacher.save 
        redirect '/'
      else #Some validation failed, back to signup...
        #flash[:message] = "Error!" #How to recognize which field didn't validate correctly?
        redirect '/students/new'
      end #if able to save
    end #if
  end #action

end #class