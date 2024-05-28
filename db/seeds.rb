require 'faker'

User.destroy_all
Contact.destroy_all

users = []
5.times do
  users << User.create!(
    email: Faker::Internet.unique.email,
    password: 'password',
    password_confirmation: 'password'
  )
end

users.each do |user|
  10.times do
    address = Faker::Address.street_address
    city = Faker::Address.city
    state = Faker::Address.state
    zip = Faker::Address.zip
    full_address = "#{address}, #{city}, #{state}, #{zip}"
    
    coordinates = Geocoder.search(full_address).first&.coordinates || [Faker::Address.latitude, Faker::Address.longitude]
    
    Contact.create!(
      name: Faker::Name.name,
      cpf: CPF.generate(true),
      phone: Faker::PhoneNumber.phone_number,
      address: address,
      city: city,
      state: state,
      zip: zip,
      latitude: coordinates[0],
      longitude: coordinates[1],
      user: user
    )
  end
end

puts "Seed completed! Created #{User.count} users and #{Contact.count} contacts."
