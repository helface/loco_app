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
Service.create!(title: "local insider", desc: "You can show travelers around better than any giant tour company with ugly buses can.")
Service.create!(title: "meal companion", desc: "Show off your cooking to travelers or share a meal with them at your favourite restaurant.")
Service.create!(title: "chauffeur", desc: "Take travelers whereever they need to go, in your car, in your tuk tuk, in your space shuttle... ")
Service.create!(title: "translator", desc: "Welcome travelers by helping them communicate with the locals.")
Service.create!(title: "shopping buddy", desc: "Take travelers shopping, because you know the best shops and how to pay 20% less than the price tag.")
Service.create!(title: "adventure guide", desc: "Guide risk taking travelers on the most amazing adventures your area has to offer. Do keep them safe though.")
Service.create!(title: "nightlife expert", desc: "You know all the great bars, nightclubs, and parties. Show travelers how to hit the town local style.")

Language.delete_all
Language.create!(name: "English", code: "en" )
Language.create!(name: "French", code: "fr")
Language.create!(name: "German", code: "de")
Language.create!(name: "Chinese", code: "zh")
Language.create!(name: "Japanese", code: "ja")
Language.create!(name: "Spanish", code: "es")
Language.create!(name: "Arabic", code: "ar")
Language.create!(name: "Korean", code: "ko")
Language.create!(name: "Russian", code: "ru")
Language.create!(name: "Portugese", code: "pt")
Language.create!(name: "Hindi", code: "hi")
Language.create!(name: "Swahili", code: "sw")
Language.create!(name: "Italian", code: "it")
Language.create!(name: "Dutch", code: "nl")


