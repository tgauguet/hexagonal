FactoryBot.define do

  factory :room do
    capacity { Faker::Number.number(1) }
    superficy { Faker::Number.number(2) }
    price { Faker::Number.number(2) }
    name { Faker::Creature::Dog.name }
  end

end
