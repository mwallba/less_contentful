$LOAD_PATH.unshift(File.expand_path('.', 'lib')) unless $LOAD_PATH.include?  File.expand_path('.', 'lib')
require 'bundler'
Bundler.setup(:default, ENV['RACK_ENV'] || 'development')
