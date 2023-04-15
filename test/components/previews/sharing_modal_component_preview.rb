# frozen_string_literal: true

class SharingModalComponentPreview < ViewComponent::Preview
  def default
    render(SharingModalComponent.new(title: "title"))
  end
end
