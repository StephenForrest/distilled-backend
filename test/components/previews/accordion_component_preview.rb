# frozen_string_literal: true

class AccordionComponentPreview < ViewComponent::Preview
  def default
    render(AccordionComponent.new(title: "title"))
  end
end
