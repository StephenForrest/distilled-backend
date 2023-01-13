require 'segment/analytics'

module Analytics
    class Tracking # Rubocop:disable Metrics/ClassLength
        
        def initialize(context = {})
            @user = context[:user]
            @event = context[:event]
            @segment = Segment::Analytics.new(
                write_key: ENV.fetch('SEGMENT_WRITE_KEY'),
            )
        end
        def call
            @segment.track(
                user_id: @user.id,
                event: @event,
                properties: properties,
            )
            @segment.identify(
                user_id: @user.id,
                traits: properties,
            )
        end
        private def properties
            {
                email: @user.email,
                name: @user.name,
                created_at: @user.created_at,
                updated_at: @user.updated_at,
            }
        end        
    end
end