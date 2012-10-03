#!/usr/bin/env rake
require File.expand_path('../lib/tasks/no_rails', __FILE__)

class Rake::Application
  # "Global access to Rake DSL methods is deprecated."
  include Rake::DSL
end

# Try to run no-rails rake tasks first and fallback to rails when none is found.
Rake.application.instance_eval do
  def top_level
    if running_a_task? && requested_tasks_exist?
      super
    else
      require File.expand_path('../config/application', __FILE__)
      Deployer::Application.load_tasks
      task :default => [ :"spec:unit", :spec ]
      super
    end
  end

  def running_a_task?
    !(options.show_tasks || options.show_prereqs)
  end

  def requested_tasks_exist?
    top_level_tasks.any? { |task| lookup(task) }
  end
end
