# spec/lookbook/previews/tabs_component_preview.rb

class TabsComponentPreview < Lookbook::Preview
  def brand_tabs
    render TabsComponent.new(color: :brand, tab_1_text: 'Tab 1', tab_2_text: 'Tab 2', tab_3_text: 'Tab 3')
    end
  end

  def secondary_tabs
    render TabsComponent.new(color: :secondary, tab_1_text: 'Tab 1', tab_2_text: 'Tab 2', tab_3_text: 'Tab 3')
    end
  end

  def gray_tabs
    render TabsComponent.new(color: :gray, tab_1_text: 'Tab 1', tab_2_text: 'Tab 2', tab_3_text: 'Tab 3')
    end
  end
end
