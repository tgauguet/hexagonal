FactoryBot.define do

  factory :booking do
    status { 'accepted' }
    user_id { 1 }
    start { Date.today }
    end_day { Date.tomorrow }
    room_id { 1 }
  end

end
