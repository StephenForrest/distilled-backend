# frozen_string_literal: true

class DrawerComponent < ViewComponent::Base
  TABS = [
    { title: "Tab 1", path: "#" },
    { title: "Tab 2", path: "#" },
    { title: "Tab 3", path: "#" },
    { title: "Tab 4", path: "#" }
  ].freeze

  BOTTOM_TABS = [
    { title: "Logout", path: "#" },
    { title: "Invites", path: "#" },
    { title: "Flasks", path: "#" }
  ].freeze

  def initialize
  end

  def logo_url
    "https://via.placeholder.com/150x50"
  end

  def render?
    true
  end
end