module IceSphere
  module Strategy
    class Daily
      LAST_DAY = Date.new(9999, 12, 31)
      DAY_HOURS = (0..23).to_a

      SECOND = 1
      MINUTE = 60
      HOUR = 3600
      DAY = 86_400

      attr_accessor :start_time, :end_time, :excepted_hours, :count, :is_jitter

      def initialize(count, excepted_hours = [], is_jitter = false)
        @count = count
        @excepted_hours = excepted_hours
        @start_time = Time.new
        @end_time = Time.new
        @is_jitter = is_jitter
      end

      def all
        seconds = daily_seconds

        period.map do |date|
          seconds.map do |second|
            date.to_time + second + (jitter if is_jitter).to_i
          end
        end.flatten
      end

      def first(n = 1)
        seconds = daily_seconds

        Enumerator.new do |yielder|
          (start_date..LAST_DAY).each do |date|
            seconds.each do |second|
              yielder.yield date.to_time + second + (jitter if is_jitter).to_i
            end
          end
        end.take(n)
      end

      def last(n = 1)
        all.last(n)
      end

      private

      def daily_seconds
        Array.new(count) do |i|
          cursor = i * interval + margin
          index, reminder = cursor.divmod(HOUR.to_f)
          target_hours[index] * HOUR + reminder
        end
      end

      def interval
        (duration / count).to_i
      end

      def margin
        (interval / 2).to_i
      end

      def period
        (start_date..end_date).to_a
      end

      def duration
        target_hours.length * HOUR
      end

      def target_hours
        DAY_HOURS - excepted_hours
      end

      def start_date
        start_time.to_date
      end

      def end_date
        end_time.to_date
      end

      def jitter(denominator = 10)
        (interval / denominator * rand - margin).to_i
      end
    end
  end
end
