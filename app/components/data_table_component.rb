# app/components/data_table_component.rb

class DataTableComponent < ViewComponent::Base
  with_content_areas :header, :row, :expanded_row

  def initialize(data:, options: {})
    @data = data
    @options = options
  end
end

