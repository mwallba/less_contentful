#!/usr/bin/env ruby
require 'bundler/setup'
require 'thor'

class CLI < Thor
  desc 'list', 'List current Content'
  def list
    print 'yolo'
  end
end

CLI.start
