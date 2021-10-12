Dir["#{File.dirname(__FILE__)}/../app/**/*.rb"].each { |f| load(f) }

require 'ostruct'
require 'yaml'