# spec/lookbook/previews/input_component_preview.rb

class InputComponentPreview < Lookbook::Preview
  def with_label
    render InputComponent.new(label: "Username", placeholder: "Enter your username")
  end

  def without_label
    render InputComponent.new(placeholder: "Enter your username")
  end

  def with_error
    render InputComponent.new(label: "Username", placeholder: "Enter your username", error: "Username is taken")
  end
end
