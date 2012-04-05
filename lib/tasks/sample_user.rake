namespace :db do
    desc "fill db with sample users"
    task populate: :environment do
        User.create!(firstname: "user",
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
    end
end

            
