# app/components/avatar_component.rb

class AvatarComponent < ViewComponent::Base
  attr_accessor :image_url, :alt_text, :size

  def initialize(image_url:, alt_text:, size: "md")
    @image_url = image_url
    @alt_text = alt_text
    @size = size
  end

  def size_class
    case size
    when "sm"
      "h-8 w-8"
    when "md"
      "h-10 w-10"
    when "lg"
      "h-12 w-12"
    else
      "h-10 w-10"
    end
  end
end
