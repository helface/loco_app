
# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
LocoApp::Application.initialize!

#Enable when deploying sidekiq
#LocoApp::Application.configure do
#   config.gem 'redis'
#end
