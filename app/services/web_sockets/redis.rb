# frozen_string_literal: true

module WebSockets
  module Redis
    class << self
      def instance
        @instance ||= ::Redis.new(url: ENV['REDIS_WS_URL'] || ENV.fetch('REDIS_URL', nil))
      end
    end
  end
end
