FactoryBot.define do
    factory :user do
      email { "admin@gmail.com" }
      password { "password" }
      name { "Admin" }
      bio { "Software Engineer" }
      gender { "male" }
    end
end
