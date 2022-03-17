# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

categories = ["family", "strategy", "classic", "puzzles", "fantasy", "others"]

	if Category.count == 0
		categories.each do |c|
			Category.create(name: c)
			puts "created #{c} category"
        end
    end

	# Generate 5 users
	(1..5).each do |id|
		User.create!(
			id: id,
			email: Faker::Internet.email,
			password: "123456", 
			password_confirmation: "123456",
		)
	end


	# Generate 15 listings
	(1..15).each do |id|
		Listing.create!(
			id: id,
			listing_name: Faker::Game.title, 
			condition: rand(1..5),
			price: rand(10..30),
			listing_status: rand(1..4),
			description: Faker::Movies::Ghostbusters.quote,
			user_id: rand(1..5), 
			category_id: rand(1..6),
			shipping: rand(1..3)
		)
	end
