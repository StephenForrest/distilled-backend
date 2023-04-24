class ButtonComponent < ViewComponent::Base
  SIZES = %i[xs small medium lg xl xxl].freeze
  COLORS = %i[color primary secondary danger warning success].freeze

  def initialize(size: :medium, color: :color, text: :text)
    @size = size
    @color = color
    @text = text
  end

  def size_class
    case @size
    when :xs
      "btn-xs"
    when :small
      "btn-sm"
    when :medium
      "btn-md"
    when :lg
      "btn-lg"
    when :xl
      "btn-xl"
    when :xxl
      "btn-xxl"
    else
      "btn-md"
    end
  end

  def color_class
    case @color
    when :primary
      "btn-primary"
    when :secondary
      "btn-secondary"
    when :danger
      "btn-danger"
    when :warning
      "btn-warning"
    when :success
      "btn-success"
    else
      "btn-color"
    end
  end
end
