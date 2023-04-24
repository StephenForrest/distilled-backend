# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AvatarComponent, type: :component do
  subject(:render_component) do
    render_inline(
      described_class.new(
        image_url: image_url,
        alt_text: alt_text,
        size: size,
        shape: shape,
      )
    )
  end

  let(:image_url) { 'https://example.com/avatar' }
  let(:alt_text) { 'Example Avatar' }
  let(:size) { :md }
  let(:shape) { :circle }

  it 'renders an image' do
    render_component

    expect(page).to have_selector("img[src='#{image_url}'][alt='#{alt_text}']")
  end

  it 'renders it with a circle and medium size by default' do
    render_component

    expect(page).to have_selector("img[class='rounded-full h-10 w-10']")
  end

  context 'when the size is set to sm (small)' do
    let(:size) { :sm }

    it 'renders it with small size' do
      render_component

      expect(page).to have_selector("img[class='rounded-full h-8 w-8']")
    end
  end

  context 'when the size is set to lg (large)' do
    let(:size) { :lg }

    it 'renders it with large size' do
      render_component

      expect(page).to have_selector("img[class='rounded-full h-12 w-12']")
    end
  end

  context 'when the shape is set to square' do
    let(:shape) { :lg }

    it 'renders it as a square' do
      render_component

      expect(page).to have_selector("img[class=' h-10 w-10']")
    end
  end

  context 'when the shape is set to rounded' do
    let(:shape) { :rounded }

    it 'renders it as a rounded square' do
      render_component

      expect(page).to have_selector("img[class='rounded h-10 w-10']")
    end
  end
end
