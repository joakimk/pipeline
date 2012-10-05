#!/usr/bin/env rake
require File.expand_path('../lib/tasks/no_rails', __FILE__)

class Rake::Application
  # "Global access to Rake DSL methods is deprecated."
  include Rake::DSL
end

# Try to run no-rails tasks first. Fallback to rails if none is found.
module LoadRailsTasks
  def self.load
    require File.expand_path('../config/application', __FILE__)
    Deployer::Application.load_tasks
  end
end

Rake.application.instance_eval do
  module Rake
    class Task
      alias :old_lookup_prerequisite :lookup_prerequisite

      def lookup_prerequisite(prerequisite_name)
        if prerequisite_name == "environment" && !Rake.application.lookup(prerequisite_name)
          LoadRailsTasks.load
        end
        old_lookup_prerequisite(prerequisite_name)
      end
    end
  end

  def top_level
    if running_a_task? && requested_tasks_exist?
      super
    else
      LoadRailsTasks.load
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