class StudentsController < ApplicationController

  #Show a all of a teacher's students
  get '/:username/students' do
    binding.pry 
    if logged_in?
      #@teacher = current_user
      @teacher = Teacher.find_by(username: params[:username]) #also need to make sure that teacher is currently logged in...
      @students = @teacher.students
      erb :'students/index'
    else
      redirect '/'
    end #if
  end #action

end #class