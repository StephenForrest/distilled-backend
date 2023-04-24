class DatePickerComponentPreview < Lookbook::Preview
  def default
    DatePickerComponent.new(
      name: "date",
      value: "",
      id: "date",
      placeholder: "Select a date",
    )
  end

  def with_error
    DatePickerComponent.new(
      name: "date",
      value: "",
      id: "date",
      placeholder: "Select a date",
      error_message: "This field is required",
    )
  end
end