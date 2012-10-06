#!/usr/bin/env rake
require File.expand_path('../lib/tasks/no_rails.rb', __FILE__)
require File.expand_path('../lib/tasks/no_rails_rake_tasks.rb', __FILE__)

NoRailsRakeTasks.load_rails_when_needed_with(Proc.new {
  require File.expand_path('../config/application', __FILE__)
  Deployer::Application.load_tasks
})
