# frozen_string_literal: true

class RadioLookbook < Lookbook::Base
  view :round_radio do
    render RadioComponent.new(label: "Round Radio", options: ["Option 1", "Option 2"], shape: :round)
  end

  view :square_radio do
    render RadioComponent.new(label: "Square Radio", options: ["Option 1", "Option 2"], shape: :square)
  end
end