require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end
    
  helpers do
    def logged_in?
        !!current_user
    end #logged_in?

    def current_user
        @current_user ||= Teacher.find_by(id: session[:id]) if session[:id]
    end #current_user
  end #helpers

end #class