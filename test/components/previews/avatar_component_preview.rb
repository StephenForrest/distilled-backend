# frozen_string_literal: true

class AvatarComponentPreview < ViewComponent::Preview
  # @param image_url text "Required. URL of image to be src="
  # @param alt_text text "Required. Alt text of image to be alt="
  # @param size select { choices: [sm, md, lg] } "Optional size. Default: md"
  # @param shape select { choices: [circle, rounded, square] } "Optional shape. Default: circle"
  def default(image_url: 'https://picsum.photos/id/64/150', alt_text: 'User Avatar', size: :md, shape: :circle)
    render(
      AvatarComponent.new(
        image_url: image_url,
        alt_text: alt_text,
        size: size,
        shape: shape,
      )
    )
  end

  def square
    render(
      AvatarComponent.new(
        image_url: 'https://picsum.photos/id/64/150',
        alt_text: 'User Avatar',
        shape: :square,
      )
    )
  end

  def rounded
    render(
      AvatarComponent.new(
        image_url: 'https://picsum.photos/id/64/150',
        alt_text: 'User Avatar',
        shape: :rounded,
      )
    )
  end

  def small
    render(
      AvatarComponent.new(
        image_url: 'https://picsum.photos/id/64/150',
        alt_text: 'User Avatar',
        size: :sm,
      )
    )
  end

  def large
    render(
      AvatarComponent.new(
        image_url: 'https://picsum.photos/id/64/150',
        alt_text: 'User Avatar',
        size: :lg,
      )
    )
  end
end
