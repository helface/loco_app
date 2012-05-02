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