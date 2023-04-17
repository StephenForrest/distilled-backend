# spec/components/previews/flask_purchase_component_preview.rb

class FlaskPurchaseComponentPreview < ViewComponent::Preview
  def default
    render(FlaskPurchaseComponent.new)
  end
end
