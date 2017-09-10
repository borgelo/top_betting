class User < ActiveRecord::Base
  has_many:bets
  attr_accessor :points
  attr_accessor :round_points
  attr_accessor :total_points
  attr_accessor :hasBets
end
