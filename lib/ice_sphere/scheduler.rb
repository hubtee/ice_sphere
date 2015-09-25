module IceSphere
  class Scheduler
    extend Forwardable

    SECOND = 1
    MINUTE = 60
    HOUR = 3600
    DAY = 86_400

    def_delegators :@strategy, :all, :first, :last
    attr_accessor :unit, :start_time, :end_time, :strategy

    def initialize(start_time, end_time, strategy)
      fail NotValidTimeError if start_time > end_time

      @start_time = start_time
      @end_time = end_time
      @strategy = strategy

      strategy.start_time = start_time
      strategy.end_time = end_time
    end
  end

  class NotValidTimeError < StandardError; end
end
