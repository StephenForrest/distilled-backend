# app/components/date_picker_component.rb

class DatePickerComponent < ViewComponent::Base
  def initialize(name:, value:, id:, placeholder:, error_message: nil)
    @name = name
    @value = value
    @id = id
    @placeholder = placeholder
    @error_message = error_message
  end
end
