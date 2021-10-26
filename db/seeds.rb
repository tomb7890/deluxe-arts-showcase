# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Artist.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'gleaner'

gleaner = Gleaner.new
gleaner.init

allartists = gleaner.artists
allartists.each do |gleanedartist|

  # unless Artist.find_by(name: a['name'])
  if true then
    artist = Artist.new(name:  gleanedartist['name'],
                  description: gleanedartist['description'],
                  image: gleanedartist['image'],
                  website: gleanedartist['website']
              )


    gleanedartist['genres'].split(",").each do | genrestringuntrimmed |
      genrestring = genrestringuntrimmed.strip

      unless genrestring.blank? 
        # ensure genre is in the db 
        dbgenre = Genre.find_or_create_by(name: genrestring) 

        # apply it to current restaurant if need be 
        if artist.genres.find_by(name: genrestring).nil?
          artist.genres << dbgenre
        end
      end
    end
    artist.save

    
  end

end


