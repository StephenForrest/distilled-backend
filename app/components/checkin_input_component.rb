# app/components/wysiwyg_editor_component.rb

class CheckinInputComponent < ViewComponent::Base
  def initialize(text:)
    @text = text
  end

  def toolbar_buttons
    [
      { type: :bold, label: "Bold", icon: "bold" },
      { type: :italic, label: "Italic", icon: "italic" },
      { type: :underline, label: "Underline", icon: "underline" },
      { type: :strikethrough, label: "Strikethrough", icon: "strikethrough" },
      { type: :justifyLeft, label: "Align left", icon: "align-left" },
      { type: :justifyCenter, label: "Align center", icon: "align-center" },
      { type: :justifyRight, label: "Align right", icon: "align-right" },
      { type: :insertUnorderedList, label: "Bulleted list", icon: "list-ul" },
      { type: :insertOrderedList, label: "Numbered list", icon: "list-ol" },
      { type: :indent, label: "Increase indent", icon: "indent" },
      { type: :outdent, label: "Decrease indent", icon: "outdent" },
      { type: :createLink, label: "Insert link", icon: "link" },
      { type: :unlink, label: "Remove link", icon: "unlink" },
      { type: :insertImage, label: "Insert image", icon: "image" }
    ]
  end
end
