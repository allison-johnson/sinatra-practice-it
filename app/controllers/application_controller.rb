require './config/environment'  #Is this necessary?

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end
  
  #index action
  get '/' do
    erb :'index'
  end #action

  get '/failure' do
    @teacher = Teacher.find_by(id: session[:id])
    erb :'failure'
  end

  helpers do
    def logged_in?
        !!current_user
    end #logged_in?

    def current_user
        @current_user ||= Teacher.find_by(id: session[:id]) if session[:id]
    end #current_user

    def set_teacher(a_hash = params) 
      @teacher = Teacher.find_by(id: a_hash[:id])
    end #set_teacher

    def set_student(a_hash = params) 
      @student = Student.find_by(id: a_hash[:id])
    end #set_teacher

    def authorized?(record)
      logged_in? && record.username == current_user.username
    end #authorized?
  end #helpers

end #class