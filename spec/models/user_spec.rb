require 'rails_helper'

RSpec.describe User, type: :model do

  it "is valid with valid attributes" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "is not valid without a phone number" do
    user = FactoryBot.build(:user, phone_number: nil)
    expect(user).to_not be_valid
  end

  it "is not valid without a name" do
    user = FactoryBot.build(:user, name: nil)
    expect(user).to_not be_valid
  end

  it "is not valid without an email" do
    user = FactoryBot.build(:user, email: nil)
    expect(user).to_not be_valid
  end

  it "is not valid without a long bio (50 chars)" do
    user = FactoryBot.build(:user, bio: 'hello')
    expect(user).to_not be_valid
  end

  it "is not valid if phone number is too short" do
    user = FactoryBot.build(:user, phone_number: '34567')
    expect(user).to_not be_valid
  end

  it "is not valid if phone number is too long" do
    user = FactoryBot.build(:user, phone_number: '345787445678765456784567')
    expect(user).to_not be_valid
  end

end
