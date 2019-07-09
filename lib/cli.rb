#!/usr/bin/env ruby
require_relative './environment'
require 'thor'

class CLI < Thor
  desc 'list', 'List current Content'
  def list
    print 'yolo'
  end
end

CLI.start
