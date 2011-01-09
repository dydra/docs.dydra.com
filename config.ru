require 'rubygems'
require 'bundler/setup'
$:.unshift Dir.pwd
require 'docs'

run Sinatra::Application
