# app/components/activity_feed_component_preview.rb

class ActivityFeedComponentPreview < ViewComponent::Preview
  def default
    activities = [
      {
        user_avatar: "https://i.pravatar.cc/300?img=1",
        user_name: "John Doe",
        date: "3 days ago",
        description: "Completed 50% of course",
        badge: "50%",
      },
      {
        user_avatar: "https://i.pravatar.cc/300?img=2",
        user_name: "Jane Doe",
        date: "5 days ago",
        description: "Started new course",
      },
      {
        user_avatar: "https://i.pravatar.cc/300?img=3",
        user_name: "Bob Smith",
        date: "7 days ago",
        description: "Completed course",
        badge: "100%",
      },
    ]

    render(ActivityFeedComponent.new(activities: activities))
  end
end
