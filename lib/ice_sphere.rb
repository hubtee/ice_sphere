require 'logger'

$LOAD_PATH.unshift File.dirname(__FILE__)

module IceSphere
  autoload :Scheduler, 'ice_sphere/scheduler'
  autoload :Strategy, 'ice_sphere/strategy'

  Logger = ::Logger.new(STDOUT)
end
