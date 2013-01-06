module ApplicationHelper
  
  def default_title(page_title)
    default_title = "tiniHost"
    if page_title.empty?
      default_title
    else
      "#{default_title} | #{page_title}"
    end
  end
  
  def default_keywords(keywords)
    default_keywords = "travel, guides, locals, travelers, hosts, local guides, green travel"
    if keywords.empty?
      default_keywords
    else
      "#{default_keywords} #{keywords}"
    end
  end
  
  def default_description(desc)
    default_description = "tiniHost connects travelers and locals for a more authentic, personal, and responsible travel experience."
    if desc.empty?
      default_description
    else
      desc
    end
  end
end
