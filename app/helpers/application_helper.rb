module ApplicationHelper
  BASE_TITLE = "Ruby on Rails Tutorial Sample App"

  def full_title(title)
    return BASE_TITLE if title.blank?
    return "#{BASE_TITLE} | #{title}"

  end

  def logo
    image_tag "logo.png", :alt => "Sample App", :class => "round", :border => "1px"
  end
end
