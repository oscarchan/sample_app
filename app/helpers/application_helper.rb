module ApplicationHelper
  BASE_TITLE = "Ruby on Rails Tutorial Sample App"

  def title
    return BASE_TITLE if @title.nil?
    return "#{BASE_TITLE} | #{@title}"

  end
end
