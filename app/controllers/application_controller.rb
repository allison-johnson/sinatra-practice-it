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
      # attr_sym = attr.to_sym  #attr is a parameter
      # @teacher = Teacher.find_by(attr_sym: a_hash[:attr_sym])
      @teacher = Teacher.find_by(id: a_hash[:id])
    end #set_teacher

    def set_student 
      @student = Student.find_by(id: params[:id])
    end #set_teacher

    def set_question 
      @question = Question.find_by(id: params[:id])
    end #set_teacher

    def authorized?(record, attr)
      logged_in? && record.send("#{attr}") == current_user.send("#{attr}")
    end #authorized?

    def redirect_if_not_logged_in
      if !logged_in?
        redirect '/login'
      end #if
    end #redirect_if_not_logged_in 
  end #helpers

end #class