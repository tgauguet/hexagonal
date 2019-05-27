require 'faker'

20.times do

  user = User.new(
    name: Faker::Name.first_name,
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    phone_number: '4567892392'
  )
  user.skip_confirmation!
  user.save!
  user.request.update(status: 'accepted')

end
