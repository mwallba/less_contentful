# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path(__dir__)) unless $LOAD_PATH.include? File.expand_path(__dir__)
require 'bundler'
Bundler.setup(:default, ENV['RACK_ENV'] || 'development')
