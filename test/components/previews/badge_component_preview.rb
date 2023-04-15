# frozen_string_literal: true

class BadgeComponentPreview < ViewComponent::Preview

  def default_theme
    render BadgeComponent.new(theme: :product, text: :default) do
      "Product Badge"
    end
  end
  def engineering_theme
    render BadgeComponent.new(theme: :engineering, text: :engineering) do
      "Engineering Badge"
    end
  end
  def design_theme
    render BadgeComponent.new(theme: :design, text: :design) do
      "Design Badge"
    end
  end
  def marketing_theme
    render BadgeComponent.new(theme: :marketing, text: :marketing) do
      "Marketing Badge"
    end
  end
  def sales_theme
    render BadgeComponent.new(theme: :sales, text: :sales) do
      "Sales Badge"
    end
  end
  def support_theme
    render BadgeComponent.new(theme: :support, text: :support) do
      "Support Badge"
    end
  end

  # @!endgroup

  private


  def theme
    BadgeComponent::THEMES.map do |theme|
      [theme.to_s.titleize, theme]
    end
  end
end