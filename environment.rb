Dir["#{__dir__}/lib/*.rb"].each { |f| load(f) }
Dir["#{__dir__}/app/**/*.rb"].each { |f| load(f) }
require 'ostruct'
require 'yaml'
