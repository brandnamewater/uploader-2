# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


youtubers = Category.find_or_create_by(name: 'YouTubers')
actors = Category.find_or_create_by(name: 'Actors')
influencers = Category.find_or_create_by(name: 'Influencers')
comedians = Category.find_or_create_by(name: 'Comedians')
gamers = Category.find_or_create_by(name: 'Gamers')
rappers = Category.find_or_create_by(name: 'Rappers')
models = Category.find_or_create_by(name: 'Models')
musicians = Category.find_or_create_by(name: 'Musicians')
