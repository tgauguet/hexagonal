require 'rails_helper'

RSpec.describe Room, type: :model do

  it 'should create a room' do
    room = FactoryBot.create(:room)
    expect(room).to be_valid
  end

  it 'shoudn\'t create a room without a name' do
    room = FactoryBot.build(:room, name: nil)
    expect(room).to_not be_valid
  end

  it "shouldn't create a room without a superficy" do
    room = FactoryBot.build(:room, superficy: nil)
    expect(room).to_not be_valid
  end

  it "shouldn't create a room without a price" do
    room = FactoryBot.build(:room, price: nil)
    expect(room).to_not be_valid
  end

  it "should not create a room if capacity is a string" do
    room = FactoryBot.build(:room, capacity: "toto")
    expect(room).to_not be_valid
  end

  it 'should not create a room if superficy is a string' do
    room = FactoryBot.build(:room, superficy: 'toto')
    expect(room).to_not be_valid
  end

  it "shouldn't create a room without a capactity" do
    room = FactoryBot.build(:room, capacity: nil)
    expect(room).to_not be_valid
  end

end
