# Load the Rails application.
require File.expand_path('../application', __FILE__)

YAML.load_file("#{::Rails.root}/config/password.yml").each {|key, value| ENV[key] = value }

# Initialize the Rails application.
Rails.application.initialize!
