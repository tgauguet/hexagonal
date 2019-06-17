FactoryBot.define do

  factory :user do
    name { Faker::Creature::Dog.name }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    bio { Faker::Lorem.paragraphs(3) }
    phone_number { '4567892392' }
  end

end
