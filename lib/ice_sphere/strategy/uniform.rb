module IceSphere
  module Strategy
    class Uniform
      attr_reader :count
      attr_accessor :start_time, :end_time

      def initialize(count)
        @count = count
        @start_time = Time.new
        @end_time = Time.new
      end

      def all
        Array.new(count) do |i|
          start_time + i * interval + margin
        end
      end

      def first(n)
        Enumerator.new do |yielder|
          (0..Float::INFINITY).each do |i|
            yielder.yield start_time + i * interval + margin
          end
        end.take(n)
      end

      def last(n)
        all.last(n)
      end

      private

      def margin
        (interval / 2).to_i
      end

      def interval
        (duration / count).to_i
      end

      def duration
        (end_time.to_i - start_time.to_i).to_i
      end
    end
  end
end
