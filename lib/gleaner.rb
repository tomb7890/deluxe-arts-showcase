class Gleaner
  include  SomervilleCreators

  attr_accessor :artists 

  def initializer
      @artists = getallartists
  end

end 
