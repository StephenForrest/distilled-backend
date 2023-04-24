# frozen_string_literal: true

class GoogleAuthComponentPreview < ViewComponent::Preview
  def default
    render(GoogleAuthComponent.new(title: "title"))
  end
end
