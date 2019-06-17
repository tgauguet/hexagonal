require 'rails_helper'

RSpec.describe Booking, type: :model do

  def get_user_and_room
    [FactoryBot.create(:user), FactoryBot.create(:room)]
  end

  it "should create a new booking" do
    data = get_user_and_room
    booking = FactoryBot.build(:booking, user_id: data[0].id, room_id: data[1].id)
    expect(booking).to be_valid
  end

  it "should contain a room_id" do
    data = get_user_and_room
    booking = FactoryBot.build(:booking, room_id: nil, user_id: data[0].id)
    expect(booking).to_not be_valid
  end

  it "should contain a user_id" do
    data = get_user_and_room
    booking = FactoryBot.build(:booking, user_id: nil, room_id: data[1].id)
    expect(booking).to_not be_valid
  end

  it "should contain a start date" do
    data = get_user_and_room
    booking = FactoryBot.build(:booking, start: nil, user_id: data[0].id, room_id: data[1].id)
    expect(booking).to_not be_valid
  end

  it "should contain an end date" do
    data = get_user_and_room
    booking = FactoryBot.build(:booking, end_day: nil, user_id: data[0].id, room_id: data[1].id)
    expect(booking).to_not be_valid
  end

end
