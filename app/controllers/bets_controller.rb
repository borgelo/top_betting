require 'nokogiri'
require 'open-uri'
class BetsController < ApplicationController
  before_action :set_bet, only: [:show, :edit, :update, :destroy]

  @@currentSeasonStartYear = 2017

  # GET /bets
  # GET /bets.json
  def index
    season = params[:season]
    @useSeason = @@currentSeasonStartYear
    if season
      @useSeason = season.to_i
    end

    if (is_long_time_since_update)
      #un comment to start new season.
      update_teams
    end
    @users = User.all
    for user in @users do
      user.hasBets = false
      user.points = 0
      user.round_points = get_round_points(user, @useSeason)
      user.total_points = user.round_points

      for bet in user.bets do
        if (bet.seasonstartyear == @useSeason)
          user.hasBets = true
          if (bet.position == bet.league.position)
            user.points += 15
            user.total_points += 15
            bet.points = 15
          elsif (bet.league.isTop(6))
            user.points += 5
            user.total_points += 5
            bet.points = 5
          else
            bet.points = 0
          end
        end
      end
    end
    @users_sorted = @users.to_a
    @users_sorted = @users_sorted.sort_by{|u| -u.points}
  end

  def get_round_points(user, season)
    user_sum = 0

    @leaguerounds = Leagueround.where('seasonstartyear = ? ',  season).
        order(played: :desc, points: :desc, goal_difference: :desc)
    pos = 0
    lastPlayed = 0
    @leaguerounds.each do |team|
      if team.played != lastPlayed
        pos = 1
      end
      lastPlayed = team.played
      if pos < 7
        bets = Bet.where('seasonStartYear = ? AND position = ?', season, pos)


        for bet in user.bets do
          if (bet.seasonstartyear == season && bet.position == pos && bet.league.name == team.name)
            user_sum += 1
          end
        end
      end
      pos = pos + 1
    end
    user_sum
  end
  
  def update_teams
    doc = Nokogiri::XML(open('https://www.footballwebpages.co.uk/league.xml?comp=1'))
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
                                       name, @@currentSeasonStartYear, @league.played)


      if (@leagueround.count == 0)
        @leagueround = Leagueround.new
        @leagueround.name = name
        @leagueround.played = team.at_xpath('played').content
        @leagueround.win = team.at_xpath('won').content
        @leagueround.drawn = team.at_xpath('drawn').content
        @leagueround.lost = team.at_xpath('lost').content
        @leagueround.for = team.at_xpath('for').content
        @leagueround.against = team.at_xpath('against').content
        @leagueround.goal_difference = team.at_xpath('goalDifference').content
        @leagueround.points = team.at_xpath('points').content
        @leagueround.seasonstartyear = @@currentSeasonStartYear
        @leagueround.save
      end

    end
  end
    

  # GET /bets/1
  # GET /bets/1.json
  def show
  end

  # GET /bets/new
  def new
    @bet = Bet.new
    @currentSeasonStartYear = @@currentSeasonStartYear
  end

  # GET /bets/1/edit
  def edit
  end

  # POST /bets
  # POST /bets.json
  def create
    @bet = Bet.new(bet_params)

    respond_to do |format|
      if @bet.save
        format.html { redirect_to @bet, notice: 'Bet was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bet }
      else
        format.html { render action: 'new' }
        format.json { render json: @bet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bets/1
  # PATCH/PUT /bets/1.json
  def update
    respond_to do |format|
      if @bet.update(bet_params)
        format.html { redirect_to @bet, notice: 'Bet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bets/1
  # DELETE /bets/1.json
  def destroy
    @bet.destroy
    respond_to do |format|
      format.html { redirect_to bets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bet
      @bet = Bet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bet_params
      params.require(:bet).permit(:user_id, :league_id, :position, :seasonstartyear)
    end
    
    def is_long_time_since_update
      now = DateTime.now
      latest_update = League.first.updated_at
      distance_in_hour = ((now.to_i - latest_update.to_i).abs) / 3600
      distance_in_hour > 1
      true
    end
end
