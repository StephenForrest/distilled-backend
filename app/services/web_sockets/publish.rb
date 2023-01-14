# frozen_string_literal: true

module WebSockets
  class Publish
    include CallableService
    TOPIC = 'distilled:websocket:pubsub'

    def initialize(id, event_name, payload, channel = 'workspace')
      @id = id
      @event_name = event_name
      @payload = payload
      @channel = channel
    end

    def call
      ::WebSockets::Redis.instance.publish(
        TOPIC,
        JSON.generate(type: event_name, payload: payload, channel: "private:#{channel}:#{id}")
      )
    end

    private

    attr_reader :id, :event_name, :payload, :channel
  end
end
