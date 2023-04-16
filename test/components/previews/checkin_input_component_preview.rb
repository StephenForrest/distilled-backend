# frozen_string_literal: true

class CheckinInputComponentPreview < ViewComponent::Preview
  def default
    render CheckinInputComponent.new(text: :text)
  end
end
