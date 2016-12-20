# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.delete_all
Portfolio.delete_all


50.times do
	User.create(
		firstname: Faker::Name.first_name,
		lastname: Faker::Name.last_name,
		email: Faker::Internet.email,
		password: 'testpassword',
		job_id: Job.order("RANDOM()").first.id,
		ville_id: Ville.order("RANDOM()").first.id,
	)
end

50.times do | i |
	Portfolio.create(
		user_id: i ,
		url: Faker::Internet.url('example.com'),
	)
end