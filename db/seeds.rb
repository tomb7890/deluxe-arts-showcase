# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Artist.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'artistsgleaner'

g = Gleaner.new

allartists = g.getartists 


unless Artist.find_by(name: g['name'])
  Artist.create(name:  g['name'],
                description: g['description'],
                image: g['image'],
                website: g['website']
               )
end
