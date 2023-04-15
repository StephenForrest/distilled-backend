# app/components/north_star_modal_component.rb

class NorthStarModalComponent < ViewComponent::Base
  with_content_areas :header, :title, :description, :author, :creation_date, :health

  def initialize(company_name:, star_icon: nil)
    @company_name = company_name
    @star_icon = star_icon
  end
end
