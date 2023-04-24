class ProgressBarComponentPreview < ViewComponent::Preview
  # @param percent number

  def default(percent: :percent)
    render ProgressBarComponent.new(percent: percent)
  end
end
