# frozen_string_literal: true

class NorthStarModalComponentPreview < ViewComponent::Preview
  def default
    render(NorthStarModalComponent.new(title: "title"))
  end
end
