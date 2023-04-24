# app/components/icon_component.rb

class IconComponent < ViewComponent::Base
  def initialize(name:, url: nil)
    @name = name
    @url = url
  end

  def icon_classes
    "icon icon-#{@name}"
  end

  def icon_style
    if @url
      "background-image: url(#{@url})"
    end
  end
end
