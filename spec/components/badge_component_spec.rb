# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BadgeComponent, type: :component do
  subject(:render_component) { render_inline(described_class.new(theme)) { text } }

  let(:theme) { :product }
  let(:text) { 'Badge Text' }
  let(:base_styles) { 'inline-block rounded-full px-3 py-1 font-semibold border' }

  it 'renders the badge' do
    render_component

    expect(page).to have_selector("span[class='#{base_styles} bg-badge-product']", text: text)
  end

  context 'when the theme is product' do
    let(:theme) { 'product' }

    it 'renders the badge in product theme' do
      render_component

      expect(page).to have_selector("span[class='#{base_styles} bg-badge-product']", text: text)
    end
  end

  context 'when the theme is engineering' do
    let(:theme) { 'engineering' }

    it 'renders the badge in engineering theme' do
      render_component

      expect(page).to have_selector("span[class='#{base_styles} bg-badge-engineering']", text: text)
    end
  end

  context 'when the theme is design' do
    let(:theme) { 'design' }

    it 'renders the badge in design theme' do
      render_component

      expect(page).to have_selector("span[class='#{base_styles} bg-brand']", text: text)
    end
  end

  context 'when the theme is marketing' do
    let(:theme) { 'marketing' }

    it 'renders the badge in marketing theme' do
      render_component

      expect(page).to have_selector("span[class='#{base_styles} bg-badge-marketing']", text: text)
    end
  end

  context 'when the theme is sales' do
    let(:theme) { 'sales' }

    it 'renders the badge in sales theme' do
      render_component

      expect(page).to have_selector("span[class='#{base_styles} bg-badge-sales']", text: text)
    end
  end

  context 'when the theme is support' do
    let(:theme) { 'support' }

    it 'renders the badge in support theme' do
      render_component

      expect(page).to have_selector("span[class='#{base_styles} bg-badge-support']", text: text)
    end
  end
end
