require 'test_helper'

class LeagueTest < ActiveSupport::TestCase
  test "first position should be top 6" do
    team = leagues(:liverpool)
    assert team.isTop(6)
  end
  
  test "sixth position should be top 6" do
    team = leagues(:swansea)
    assert team.isTop(6)
  end
  
  test "seventh position should not be top 6" do
    team = leagues(:manu)
    assert_not team.isTop(6)
  end
end
