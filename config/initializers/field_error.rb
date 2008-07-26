# Override the default behaviour to remove the fieldWithErrors div
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag
end