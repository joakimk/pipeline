#!/usr/bin/env ruby

# Script to report build status to a deployer server.
# https://github.com/joakimk/deployer

require 'net/http'
require 'uri'
require 'yaml'

class BuildStatusReporter
  def initialize(api = BuildStatusApi.new, shell = Shell.new)
    @api = api
    @shell = shell
  end

  def build_and_report(command)
    api.report_status "building"

    if shell.run(command)
      api.report_status "successful"
      true
    else
      api.report_status "failed"
      false
    end
  end

  private

  attr_reader :shell, :api

  class Shell
    def run(command)
      system(command)
    end
  end
end

class BuildStatusApi
  def initialize(config, project_id, step, revision)
    @config = config
    @project_id = project_id
    @step = step
    @revision = revision
  end

  def report_status(status)
    uri = URI(@config.url)
    data = { :project_id => @project_id, :step => @step, revision: @revision, status: status, token: @config.token }

    begin
      Net::HTTP.post_form(uri, data)
    rescue Exception
      puts "Failed to report status (#{data.inspect})."
    end
  end
end

class FullGitRevision
  # Resolves aliases like "master" to a full git
  # commit hash so that we can uniquely identify a build.
  def self.convert(revision)
    revision.match(/^[a-z0-9]{40}$/) ? revision : `git rev-parse origin/#{revision}`.chomp
  end
end

class ApiConfig
  def url
    config.fetch("url")
  end

  def token
    config.fetch("token")
  end

  def exists?
    config
  end

  def error_message
    <<EOS
Config file missing (#{path}).

Example config:
url: http://example.com/api/build_status
token: your-api-token
EOS
  end

  private

  def config
    if File.exists?(path)
      @config ||= YAML.load_file(path)
    else
      false
    end
  end

  def path
    "#{ENV["HOME"]}/.deployer_api.yml"
  end
end

if __FILE__ == $0
  if ARGV.count != 4
    puts "Usage: #{$0} project_id step revision command"
  else
    config = ApiConfig.new

    unless config.exists?
      puts config.error_message
      exit 1
    end

    project_id, step, revision, command = ARGV
    revision = FullGitRevision.convert(revision)
    api = BuildStatusApi.new(config, project_id, step, revision)
    BuildStatusReporter.new(api).build_and_report(command) || exit(1)
  end
end
