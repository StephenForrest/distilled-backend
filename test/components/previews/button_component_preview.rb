# frozen_string_literal: true

class ButtonComponentPreview < ViewComponent::Preview
  # @param size [Symbol] The size of the button
  # @param content text The text of the button
  # @param color color The color of the button

  def xs_button(content: "Extra Small Button", size: :xs, color: :color)
    render ButtonComponent.new(size: :size, color: :color) do
      content
    end
  end
  def small_button
    render ButtonComponent.new(size: :size, color: :color) do
      content
    end
  end
  def medium_button
    render ButtonComponent.new(size: :size, color: :color) do
      content
    end
  end
  def large_button
    render ButtonComponent.new(size: :size, color: :color) do
      content
    end
  end
  def xl_button
    render ButtonComponent.new(size: :size, color: :color) do
      content
    end
  end
  def xxl_button
    render ButtonComponent.new(size: :size, color: :color) do
      content
    end
  end

  # @!endgroup

  private

  def size
    ButtonComponent::SIZES.map do |size|
      [size.to_s.titleize, size]
    end
  end
end
