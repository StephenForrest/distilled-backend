# frozen_string_literal: true

class ToggleComponentPreview < ViewComponent::Preview
  def default
    render(ToggleComponent.new(title: "title"))
  end
end
