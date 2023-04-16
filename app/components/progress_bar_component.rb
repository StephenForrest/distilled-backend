class ProgressBarComponent < ViewComponent::Base
  # @param percent number
  def initialize(percent: :percent)
    @percent = percent
  end
end
