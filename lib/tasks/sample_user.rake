namespace :db do
    desc "fill db with sample users"
    task populate: :environment do
        User.create!(firstname: "fake",
                     lastname: "fake",
                     email: "fake@gmail.com",
                     password: "fakefake",
                     password_confirmation: "fakefake")
        50.times do |n|
            firstname = Faker::Name.first_name
            lastname = Faker::Name.last_name
            email = "fake#{n+1}@gmail.com"
            password = "fakefake"
            User.create!(firstname: firstname,
                         lastname: lastname,
                         email: email,
                         password: password,
                         password_confirmation: password)
        end
        users=User.all(limit: 10)
        cities = City.all
        countries = Country.all
        10.times do |n|
          content = Faker::Lorem.sentence(3)
          users.each {|user| user.reviews.create!(content: content, reviewer_id:n, reviewee_id:n+1)}
        end 
        
        users.each {|user| user.build_hostprofile(tele: 44553322, languages: ["English"], serviceDesc: 'kalkjsojojlaskjdfjasldfkj', aboutme: 'asdfasdfasdfsadfasdf', price: '$23', greenDesc: 'grenn green green')}
        users.each {|user| user.toggle!(:is_host)}
        users.each { |user| user.toggle!(:confirmed) }        
        n = 0
        users.each {|user| user.hostprofile.update_attributes(:city_id => cities[n+=1].id)}
        
        j=0
        users.each {|user| user.hostprofile.update_attributes(:service => j+=1)}
    end
    
end

            
