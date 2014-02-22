#!/usr/bin/env rake

def load_application_tasks
  load_non_rails_tasks
  load_rails_tasks_when_needed
end

def load_non_rails_tasks
  path = File.expand_path('../lib/tasks/no_rails', __FILE__)

  # These are named .rb, not .rake, or else Rails may pick them up.
  ruby_files = Dir.glob(path + "/*.rb")
  ruby_files.each { |file| load file }
end

def load_rails_tasks_when_needed
  require File.expand_path('../lib/railsless_rake_task_runner.rb', __FILE__)

  RailslessRakeTaskRunner.load_rails_when_needed_with(lambda {
    require File.expand_path('../config/application', __FILE__)
    Pipeline::Application.load_tasks
  })
end

load_application_tasks
