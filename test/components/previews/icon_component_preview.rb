# frozen_string_literal: true

class IconComponentPreview < ViewComponent::Preview
  def default
    render(IconComponent.new(name: "home"))
  end

  def custom_icon
    render(IconComponent.new(name: "custom-icon", url: "https://example.com/custom-icon.svg"))
  end
end
