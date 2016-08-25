class User < ActiveRecord::Base
  has_many:bets
  attr_accessor :points
  attr_accessor :hasBets
end
