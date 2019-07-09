# frozen_string_literal: true

require_relative './lib/environment'
require 'rspec/core/rake_task'
require 'funky_fetch'

RSpec::Core::RakeTask.new(:spec)

task default: [:spec]

task :pull do
  p FunkyFetch.call
end
