class League < ActiveRecord::Base
  def isTop(value)
    position <= value
  end  
end
