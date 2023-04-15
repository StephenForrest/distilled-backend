# spec/lookbook/previews/avatar_component_preview.rb

class AvatarComponentPreview < Lookbook::Preview
  def default
    AvatarComponent.new(
      image_url: "https://via.placeholder.com/150",
      alt_text: "User Avatar",
      size: "md"
    )
  end
end