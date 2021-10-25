class Gleaner
  include SomervilleCreators

  attr_accessor :artists 

  def initialize
    @artists = getallcreators
  end

  def getallartists
    @artists
  end

end 
