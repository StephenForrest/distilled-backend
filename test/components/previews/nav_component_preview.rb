# frozen_string_literal: true

class NavComponentPreview < ViewComponent::Preview
  def default
    render(NavComponent.new(title: "title"))
  end
end
