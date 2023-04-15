# app/components/radio_component.rb
class RadioComponent < ViewComponent::Base
  COLORS = %w[red yellow green blue indigo purple pink].freeze

  def initialize(name:, options:, selected:, square: false)
    @name = name
    @options = options
    @selected = selected
    @square = square
  end

  def square?
    @square
  end

  def selected?(value)
    @selected == value
  end

  def label_classes
    "block font-medium text-gray-700"
  end

  def radio_classes
    "text-primary-600 focus:ring-primary-500 h-4 w-4"
  end

  def radio_container_classes
    "flex items-center"
  end

  def radio_label_classes
    "ml-3 block text-sm font-medium text-gray-700"
  end

  def square_radio_classes
    "h-6 w-6 border-2 border-gray-300 rounded-md checked:bg-primary-600 checked:border-transparent focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500"
  end

  def square_radio_container_classes
    "inline-flex items-center"
  end

  def square_radio_label_classes
    "ml-2 text-sm font-medium text-gray-700"
  end
end
