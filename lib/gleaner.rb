class Gleaner
  include "somervillecreators"

  attr_accessor :artists 

  def initializer
      @artists = getallartists
  end

end 