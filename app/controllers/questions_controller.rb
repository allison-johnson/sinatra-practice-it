require 'rack-flash'

class QuestionsController < ApplicationController
  enable :sessions
  use Rack::Flash 

  #new action
  get '/questions/new' do
    redirect_if_not_logged_in
    @topics = Topic.all 
    @field_values = {}
    erb :'questions/new'
  end #action

  #show action 
  get '/questions/:id' do
    redirect_if_not_logged_in 
    set_teacher(session)
    if set_question 
      @topics = @question.topics
      @difficulty = @question.difficulty
      @prompt = @question.prompt 
      @owner_id = @question.owner_id
      erb :'questions/show'
    else
      erb :'failure'
    end
  end #action 

  #Edit action
  get '/questions/:id/edit' do
    redirect_if_not_logged_in 
    if set_question && @question.owner_id == session[:id]
      @topics = Topic.all 
      erb :'questions/edit'
    else
      set_teacher(session)
      erb :'failure'
    end #if
  end #action

  #create action
  post '/questions' do
    set_teacher(session)
    question = Question.new(difficulty: params[:difficulty], prompt: params[:prompt], owner_id: @teacher.id)
    if !question.save 
      flash[:message] = question.errors.full_messages.join(", ")
      @field_values = {prompt: params[:prompt]}
      @topics = Topic.all 
      erb :'/questions/new'
    else
      topics = params[:topics]
      if topics 
        topics.each do |topic|
          question.topics << Topic.find_by(name: topic)
        end #each
      end #if topics
      redirect "/teachers/#{session[:id]}"
    end #if
  end #action

  #update action
  patch '/questions/:id' do
    set_question 
    if !@question.update(prompt: params[:prompt])
      flash[:message] = @question.errors.full_messages.join(", ")
      @topics = Topic.all 
      erb :'/questions/edit'
    else
      @question.topics.clear
      params[:topics].each do |topic|
        @question.topics << Topic.find_by(name: topic)
      end #each
      redirect "/teachers/#{session[:id]}"
    end #if 
  end #action

  #add/remove students from a question (update action)
  patch '/questions/:id/update-students' do
    @question = Question.find_by(id: params[:id])
    @question.students.clear 
    if params[:students]
      params[:students].each do |student|
        student = Student.find_by(id: student)
        @question.students << student 
        @question.save 
      end #do
    end #if
    redirect "/teachers/#{session[:id]}"
  end #action

  #delete action
  delete '/questions/:id' do
    @question = Question.find_by(id: params[:id])
    if logged_in? && current_user.id == @question.owner_id
      Question.delete(params[:id])
      redirect "/teachers/#{session[:id]}"
    else
      redirect '/'
    end #if
  end #delete

end #class
