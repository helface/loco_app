open("lib/data/countries.txt") do |countries|
  countries.read.each_line do |country|
    code, name = country.chomp.split("|")
    Country.find_or_create_by_name_and_code(:name => name, :code => code)
  end
end

open("lib/data/cities.txt") do |cities|
  cities.read.each_line do |city|
    code, name, timezone = city.chomp.split ("|")
    cid = Country.find_by_code(code).id
    City.find_or_create_by_name_and_country_id_and_timezone(:name => name, :country_id => cid, :timezone=>timezone) unless cid.nil?
  end
end

Service.find_or_create_by_title_and_desc(title: "local insider", desc: "You can show travelers around better than any giant tour company with ugly buses can.")
Service.find_or_create_by_title_and_desc(title: "meal companion", desc: "Show off your cooking to travelers or share a meal with them at your favourite restaurant.")
Service.find_or_create_by_title_and_desc(title: "chauffeur", desc: "Take travelers whereever they need to go, in your car, in your tuk tuk, in your space shuttle... ")
Service.find_or_create_by_title_and_desc(title: "translator", desc: "Welcome travelers by helping them communicate with the locals.")
Service.find_or_create_by_title_and_desc(title: "shopping buddy", desc: "Take travelers shopping, because you know the best shops and how to pay 20% less than the price tag.")
Service.find_or_create_by_title_and_desc(title: "adventure guide", desc: "Guide risk taking travelers on the most amazing adventures your area has to offer. Do keep them safe though.")
Service.find_or_create_by_title_and_desc(title: "nightlife expert", desc: "You know all the great bars, nightclubs, and parties. Show travelers how to hit the town local style.")

Language.find_or_create_by_name_and_code(name: "English", code: "en" )
Language.find_or_create_by_name_and_code(name: "French", code: "fr")
Language.find_or_create_by_name_and_code(name: "German", code: "de")
Language.find_or_create_by_name_and_code(name: "Chinese", code: "zh")
Language.find_or_create_by_name_and_code(name: "Japanese", code: "ja")
Language.find_or_create_by_name_and_code(name: "Spanish", code: "es")
Language.find_or_create_by_name_and_code(name: "Arabic", code: "ar")
Language.find_or_create_by_name_and_code(name: "Korean", code: "ko")
Language.find_or_create_by_name_and_code(name: "Russian", code: "ru")
Language.find_or_create_by_name_and_code(name: "Portugese", code: "pt")
Language.find_or_create_by_name_and_code(name: "Hindi", code: "hi")
Language.find_or_create_by_name_and_code(name: "Swahili", code: "sw")
Language.find_or_create_by_name_and_code(name: "Italian", code: "it")
Language.find_or_create_by_name_and_code(name: "Dutch", code: "nl")
