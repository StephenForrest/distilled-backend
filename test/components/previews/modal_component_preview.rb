# frozen_string_literal: true

class ModalComponentPreview < ViewComponent::Preview
  def default
    render(ModalComponent.new(title: "title"))
  end
end
