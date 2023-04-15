# app/components/input_component.rb

class InputComponent < ViewComponent::Base
  def initialize(id:, label:, placeholder:, type: "text", value: nil)
    @id = id
    @label = label
    @placeholder = placeholder
    @type = type
    @value = value
  end

  def input_classes
    "block w-full px-3 py-2 border rounded-md shadow-sm focus:outline-none focus:ring-brand focus:border-brand sm:text-sm"
  end
end
