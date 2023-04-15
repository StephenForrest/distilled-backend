class ActivityFeedComponent < ViewComponent::Base

  def initialize(activities:)
    @activities = activities
  end
end
