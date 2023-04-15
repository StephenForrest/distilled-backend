# frozen_string_literal: true

class CheckinInputComponentPreview < ViewComponent::Preview
  def default
    render(CheckinInputComponent.new(title: "title"))
  end
end
