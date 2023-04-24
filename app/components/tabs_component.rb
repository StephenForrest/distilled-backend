
class TabsComponent < ViewComponent::Base
  COLORS = {
    brand: 'border-brand',
    secondary: 'border-secondary',
    gray: 'border-gray-500'
  }.freeze

  with_content_areas :tab_1_content, :tab_2_content, :tab_3_content

  def initialize(color:, tab_1_text:, tab_2_text:, tab_3_text:)
    @color = COLORS[color.to_sym] || 'border-gray-500'
    @tab_1_text = tab_1_text
    @tab_2_text = tab_2_text
    @tab_3_text = tab_3_text
  end
end