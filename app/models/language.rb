class Language < ActiveRecord::Base
  attr_accessible :name, :code
  
  def self.prefill_languages(langs)
     #ids = langs.split(',') unless langs.nil?
     @languages = langs.map{|l| Language.find_by_id(l)} unless langs.nil?
  end
end
