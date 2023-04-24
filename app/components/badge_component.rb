# frozen_string_literal: true

class BadgeComponent < ViewComponent::Base
  attr_reader :theme

  THEMES = {
    product: 'bg-badge-product',
    engineering: 'bg-badge-engineering',
    design: 'bg-brand',
    marketing: 'bg-badge-marketing',
    sales: 'bg-badge-sales',
    support: 'bg-badge-support',
  }.freeze

  def initialize(theme)
    super

    @theme = theme.to_sym
  end

  def theme_style
    THEMES.fetch(theme, '')
  end
end
