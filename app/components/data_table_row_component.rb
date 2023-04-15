# app/components/data_table_row_component.rb

class DataTableRowComponent < ViewComponent::Base
    with_content_areas :badge, :icon_with_data_1, :icon_with_data_2, :progress_bar, :percent, :icon, :text, :date, :avatar, :expanded_content
  
    def initialize(data:, options: {})
      @data = data
      @options = options
    end
  
    def has_expanded_row?
      content_areas[:expanded_content].present?
    end
  end
  