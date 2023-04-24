# app/components/data_table_dropdown_component.rb

class DataTableDropdownComponent < ViewComponent::Base
    with_content_areas :row, :expanded_row
  
    def initialize(data:, options: {})
      @data = data
      @options = options
    end
  
    def has_expanded_row?
      content_areas[:expanded_row].present?
    end
  end
  