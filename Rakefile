ENV["SINATRA ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

desc "opens a console"
task :console do 
  Pry.start 
end

task :seed do
  require_relative './db/seeds.rb'
end