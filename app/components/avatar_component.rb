# frozen_string_literal: true

class AvatarComponent < ViewComponent::Base
  attr_reader :image_url, :alt_text, :size, :shape

  SIZES = {
    sm: 'h-8 w-8',
    md: 'h-10 w-10',
    lg: 'h-12 w-12',
  }.freeze

  SHAPES = {
    square: '',
    rounded: 'rounded',
    circle: 'rounded-full',
  }.freeze

  def initialize(image_url:, alt_text:, size: :md, shape: :circle)
    super

    @image_url = image_url
    @alt_text = alt_text
    @size = size.to_sym
    @shape = shape.to_sym
  end

  def style_classes
    [shape_style, size_style].join(' ')
  end

  def shape_style
    SHAPES.fetch(shape, '')
  end

  def size_style
    SIZES.fetch(size, '')
  end
end
