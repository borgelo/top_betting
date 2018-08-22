require 'nokogiri'
require 'open-uri'
class Leagueround < ActiveRecord::Base
  attr_accessor :userpoints, :sumpoints

  def self.update_rounds
    @@currentSeasonStartYear = 2018

    puts "Getting data..."
    doc = Nokogiri::XML(open('https://www.footballwebpages.co.uk/league.xml?comp=1'))
    puts "data received"
    #doc = Nokogiri::XML(open('league.xml'))
    doc.xpath('//team').each do |team|
      name = team.at_xpath('name').content
      @league = League.where('name = ? AND seasonstartyear = ?', name, @@currentSeasonStartYear ).first()

      if (!@league)
        @league = League.new
      end
      @league.name = name
      @league.position = team.at_xpath('position').content
      @league.played = team.at_xpath('played').content
      @league.win = team.at_xpath('won').content
      @league.drawn = team.at_xpath('drawn').content
      @league.lost = team.at_xpath('lost').content
      @league.for = team.at_xpath('for').content
      @league.against = team.at_xpath('against').content
      @league.goal_difference = team.at_xpath('goalDifference').content
      @league.points = team.at_xpath('points').content
      @league.seasonstartyear = @@currentSeasonStartYear
      @league.save

      @leagueround = Leagueround.where('name = ? AND seasonstartyear = ? AND played = ?',
                                       name, @@currentSeasonStartYear, @league.played).first()


      if (!@leagueround)
        @leagueround = Leagueround.new
        @leagueround.name = name
        @leagueround.seasonstartyear = @@currentSeasonStartYear
      end

        @leagueround.played = team.at_xpath('played').content
        @leagueround.win = team.at_xpath('won').content
        @leagueround.drawn = team.at_xpath('drawn').content
        @leagueround.lost = team.at_xpath('lost').content
        @leagueround.for = team.at_xpath('for').content
        @leagueround.against = team.at_xpath('against').content
        @leagueround.goal_difference = team.at_xpath('goalDifference').content
        @leagueround.points = team.at_xpath('points').content
        @leagueround.save
    end
  end

end
