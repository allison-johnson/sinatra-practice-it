require './config/environment'

use Rack::MethodOverride
run ApplicationController 
use TeachersController
use StudentsController
use QuestionsController
use TopicsController 