# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Artist.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'gleaner'

g = Gleaner.new
g.init

allartists = g.getallartists
allartists.each do |a|

  unless Artist.find_by(name: a['name'])
    Artist.create(name:  a['name'],
                  description: a['description'],
                  image: a['image'],
                  website: a['website']
                 )
  end

end


