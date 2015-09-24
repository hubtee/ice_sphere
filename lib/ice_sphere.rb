require 'logger'

$LOAD_PATH.unshift File.dirname(__FILE__)

module IceSphere
  Logger = ::Logger.new(STDOUT)  
end
