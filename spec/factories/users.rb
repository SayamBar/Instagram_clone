FactoryBot.define do
    factory :user do
      email { "admin@gmail.com" }
      password { "password" }
      name { "Admin" }
      bio { "Software Engineer" }
      gender { "Male" }
    end
end
