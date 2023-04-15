# frozen_string_literal: true

class LockedResourceModalComponentPreview < ViewComponent::Preview
  def default
    render(LockedResourceModalComponent.new(title: "title"))
  end
end
