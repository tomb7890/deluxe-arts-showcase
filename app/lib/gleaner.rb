class Gleaner
  include SomervilleCreators

  attr_accessor :artists 

  def initialize
  end

  def init
    @artists = getallcreators
    set_default_image
  end

  def set_default_image
    Artist.all.each do |a|
      if a.image.blank?
        a.image = 'http://somervilleartscouncil.org/sacfiles/styles/events/public/banners/porchfestweb12.png'
        a.save
      end
    end
  end


end 
