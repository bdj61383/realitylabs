# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Realitylabs::Application.initialize!

# Adding this based on answer to problem given here: http://stackoverflow.com/questions/4114835/heroku-devise-missing-host-to-link-to-please-provide-host-parameter-or-set-d
# config.action_mailer.default_url_options = { :host => 'localhost' }
