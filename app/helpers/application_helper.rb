module ApplicationHelper
  
  def default_title(page_title)
    default_title = "locoapp"
    if page_title.empty?
      default_title
    else
      "#{default_title} | #{page_title}"
    end
  end
end
