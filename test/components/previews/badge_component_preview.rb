# frozen_string_literal: true

class BadgeComponentPreview < ViewComponent::Preview

  # @param badge_text text "Text content"
  # @param theme select { choices: [product, engineering, design, marketing, sales, support] } "Required. Badge theme."
  def default_theme(badge_text: 'Badge Text', theme: :product)
    render(BadgeComponent.new(theme)) { badge_text }
  end

  def product_theme
    render(BadgeComponent.new(:product)) { 'Product Badge' }
  end

  def engineering_theme
    render(BadgeComponent.new(:engineering)) { 'Engineering Badge' }
  end

  def design_theme
    render(BadgeComponent.new(:design)) { 'Design Badge' }
  end

  def marketing_theme
    render(BadgeComponent.new(:marketing)) { 'Marketing Badge' }
  end

  def sales_theme
    render(BadgeComponent.new(:sales)) { 'Sales Badge' }
  end

  def support_theme
    render(BadgeComponent.new(:support)) { 'Support Badge' }
  end
end
