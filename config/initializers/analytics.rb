require 'segment/analytics'

module Analytics
    class Track # Rubocop:disable Metrics/ClassLength
        ALLOWED_EVENTS = [
            Analytics::Event::User::SignedUp[:label],
            Analytics::Event::User::SignedIn[:label],
            Analytics::Event::Subscription::Created[:label],
            Analytics::Event::Trial::Started[:label],
            Analytics::Event::Trial::Ended[:label],
            Analytics::Event::Subscription::Finalized[:label],
            Analytics::Event::Subscription::Canceled[:label],
            Analytics::Event::Subscription::Resumed[:label],
            Analytics::Event::Subscription::Paid[:label],
            Analytics::Event::Subscription::PaymentFailed[:label],
            Analytics::Event::Subscription::PaymentSucceeded[:label],
            Analytics::Event::Subscription::PaymentRefunded[:label],
            Analytics::Event::Subscription::Updated[:label]
        ].freeze
        
        def initialize(context = {})
            @user = context[:user]
            @event = context[:event]
            @segment = Segment::Analytics.new(
                write_key: ENV.fetch['SEGMENT_WRITE_KEY'],
        end

        def call
            return unless @user && @event

            @segment.track(
                user_id: @user.id,
                event: @event[:label],
                properties: @event[:properties]
            )
        end