Country.delete_all
open("lib/data/countries.txt") do |countries|
  countries.read.each_line do |country|
    code, name = country.chomp.split("|")
    Country.create!(:name => name, :code => code)
  end
end

City.delete_all
open("lib/data/cities.txt") do |cities|
  cities.read.each_line do |city|
    code, name = city.chomp.split ("|")
    cid = Country.find_by_code(code).id
    City.create!(:name => name, :country_id => cid) unless cid.nil?
  end
end

Service.delete_all
Service.create!(title: "local insider", desc: "show you city")
Service.create!(title: "meal companion", desc: "you have food")
Service.create!(title: "schoefer", desc: "you drive around")
Service.create!(title: "translator", desc: "you translate")
Service.create!(title: "shopping buddy", desc: "you go shopping")
Service.create!(title: "adventure guide", desc: "you try not to die")
Service.create!(title: "nightlife expert", desc: "you party")

Language.delete_all
Language.create!(name: "English", code: "en" )
Language.create!(name: "French", code: "fr")
Language.create!(name: "German", code: "AL")
Language.create!(name: "Chinese", code: "CH")
Language.create!(name: "Japanese", code: "JP")
Language.create!(name: "Spanish", code: "SP")
Language.create!(name: "Arabic", code: "AR")
Language.create!(name: "Korean", code: "KO")
Language.create!(name: "Russian", code: "RU")
Language.create!(name: "Portugese", code: "PT")
Language.create!(name: "Hindi", code: "HD")
Language.create!(name: "Swahili", code: "SW")
Language.create!(name: "Italian", code: "IT")


