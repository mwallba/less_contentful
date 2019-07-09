#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './environment'
require 'thor'

class CLI < Thor
  desc 'list', 'List current Content'
  def list
    print 'yolo'
  end
end

CLI.start
