# frozen_string_literal: true

class ProgressBarComponentPreview < ViewComponent::Preview
  def default
    render(ProgressBarComponent.new(title: "title"))
  end
end
