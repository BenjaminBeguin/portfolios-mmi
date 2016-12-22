# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


 User.delete_all
 Portfolio.delete_all
 Job.delete_all
 
 Ville.update_all(like: 0);

10.times do
	Ville.create(
		label: Faker::Address.city,
		like: 0
	)
end

Job.create(label: "Développeur", slug: "developpeur" )
Job.create(label: "Designer", slug: "designer" )
Job.create(label: "Graphiste", slug: "graphiste" )
Job.create(label: "Référenceur", slug: "referenceur" )
Job.create(label: "Intégrateur", slug: "integrateur" )


User.create(
		firstname: "Admin",
		lastname: "Admin",
		email: "beguin.ben@gmail.com",
		password: 'adminpassword',
		job_id: Job.order("RANDOM()").first.id,
		ville_id: Ville.order("RANDOM()").first.id,
		admin: true
	)


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

10.times do
	Portfolio.create(
		user_id: User.order("RANDOM()").first.id,
		url: Faker::Internet.url('example.com'),
	)
end