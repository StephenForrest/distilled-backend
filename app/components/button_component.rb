class ButtonComponent < ViewComponent::Base

  SIZES = %i[xs, small, medium, lg, xl, xxl].freeze

  def initialize(size: :size, color: :color, text: :text)
    @size = size
    @color = color
    @text = text
  end
  def sizes
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
     end
  end

  def dropdown_button_classes
    classes = "relative"
    classes += " inline-flex items-center" unless @dropdown_options[:block]
    classes += " border border-gray-300 text-sm font-medium rounded-md shadow-sm"
    classes += " text-gray-700 bg-white hover:text-gray-500"
    classes += " focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
    classes
  end

  def dropdown_menu_classes
    classes = "absolute right-0 mt-2 w-56 rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5"
    classes += " py-1" unless @dropdown_options[:vertical_padding] == false
    classes += " focus:outline-none"
    classes
  end


  def dropdown_menu_items
    @dropdown_options[:items] || []
  end

  def dropdown_menu_item_classes
    "block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900"
  end

  def dropdown_button_content
    content_tag :button, class: dropdown_button_classes do
      if @text.present?
        content_tag(:span, @text, class: "truncate")
      end +
      tag.svg(class: "w-5 h-5 ml-2 -mr-1", viewBox: "0 0 20 20", fill: "none", stroke: "currentColor") do
        tag.path(d: "M10 14l6-6m0 0l-6-6m6 6h-12", stroke_width: "2", stroke_linecap: "round", stroke_linejoin: "round")
      end
    end
  end

  def dropdown_menu_content
    content_tag :div, class: dropdown_menu_classes do
      dropdown_menu_items.map do |item|
        content_tag :a, item[:text], href: item[:url], class: dropdown_menu_item_classes
      end.join.html_safe
    end
  end
  def dropdown_content
    dropdown_button_content + dropdown_menu_content
  end
  
  def content
    if @dropdown
      dropdown_content
    else
      button_content
    end
  end
end
    
    
