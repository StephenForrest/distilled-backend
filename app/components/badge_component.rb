class BadgeComponent < ViewComponent::Base
  
  THEMES = %i[product engineering design marketing sales support].freeze

  def initialize(theme: :theme_options, text: :text)
      @theme = theme
      @text = text
  end
      
  def theme
      case @theme
      when :product
          "bg-badge-product"
      when :engineering
          "bg-badge-engineering"
      when :design
          "bg-badge-design"
      when :marketing
          "bg-badge-marketing"
      when :sales
          "bg-badge-sales"
      when :support
          "bg-badge-support"
       end
  end
  def text
      case @text
      when :product
          "Product Badge"
      when :engineering
          "Engineering Badge"
      when :design
          "Design Badge"
      when :marketing
          "Marketing Badge"
      when :sales
          "Sales Badge"
      when :support
          "Support Badge"
      end
   end
end