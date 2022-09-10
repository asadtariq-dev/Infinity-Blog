# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Author.create!(email: 'asad.tariq@devsinc.com', first_name: 'Admin', last_name: 'Account', role: 'admin',
               confirmed_at: Time.now, password: '12345678')
