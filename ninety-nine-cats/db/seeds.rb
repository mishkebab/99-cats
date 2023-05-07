# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
ApplicationRecord.transaction do 
    puts "destroying..."
    Cat.destroy_all
    puts "resetting id seq..."
    ApplicationRecord.connection.reset_pk_sequence!("cats")
    puts "seeding..."
    cat1 = Cat.create!(name: "Rohan", color: "brown", sex: "M", birth_date: "22/8/2000", description: "cute cat!")
    cat2 = Cat.create!(name: "Misha", color: "orange", sex: "F", birth_date: "9/7/1995", description: "baddie")
    cat3 = Cat.create!(name: "Paulo", color: "gray", sex: "M", birth_date: "27/3/1993", description: "peruvian cool cat")
end 