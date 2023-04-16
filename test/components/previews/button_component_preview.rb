# frozen_string_literal: true

class ButtonComponentPreview < ViewComponent::Preview
  # @param size [Symbol] The size of the button
  # @param color color The color of the button

  def xs_button(text: "Extra Small Button", size: :xs, color: :color)
    render ButtonComponent.new(size: size, color: color) do
      text
    end
  end
  def small_button(text: "Small Button", size: :small, color: :color)
    render ButtonComponent.new(size: size, color: color) do
      text
    end
  end
  def medium_button(text: "Medium Button", size: :medium, color: :color)
    render ButtonComponent.new(size: size, color: color) do
      text
    end
  end
  def large_button(text: "Large Button", size: :lg, color: :color)
    render ButtonComponent.new(size: size, color: color) do
      text
    end
  end
  def xl_button(text: "Extra Large Button", size: :xl, color: :color)
    render ButtonComponent.new(size: size, color: color) do
      text
    end
  end
  def xxl_button(text: "XXL Button", size: :xxl, color: :color)
    render ButtonComponent.new(size: size, color: color) do
      text
    end
  end

  # @!endgroup

  private

  def button_sizes
    ButtonComponent::SIZES.map do |size|
      [size.to_s.titleize, size]
    end
  end
end
