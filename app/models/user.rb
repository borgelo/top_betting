class User < ActiveRecord::Base
  has_many:bets
  attr_accessor :points
end
