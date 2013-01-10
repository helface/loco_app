class PagesController < ApplicationController
  def home
  end

  def find
  end

  def about
  end
  
  def terms_of_service
  end
  
  def privacy 
  end
  
  def hostduty
    render '_hostinfo'
  end
end
