require 'nokogiri'
require 'open-uri'
class BetsController < ApplicationController
  before_action :set_bet, only: [:show, :edit, :update, :destroy]

  # GET /bets
  # GET /bets.json
  def index
    if is_long_time_since_update
      update_teams
    end
    @users = User.all
    puts @users.class 
    for user in @users do
      user.points = 0
      for bet in user.bets do
        if (bet.position == bet.league.position)
          user.points = user.points += 3
          bet.points = 3
        elsif (bet.league.isTop(6))
          user.points += 1
          bet.points = 1
        else
          bet.points = 0
        end        
      end
      if user.name == 'Robin'
        #user.points = 3
      end
    end
    @users_sorted = @users.to_a
    @users_sorted = @users_sorted.sort_by{|u| -u.points}
  end
  
  def update_teams
    doc = Nokogiri::XML(open('http://www.footballwebpages.co.uk/league.xml?comp=1'))  
    #doc = Nokogiri::XML(open('league.xml'))
    doc.xpath('//team').each do |team|
      name = team.at_xpath('name').content
      @league = League.find_by_name(name)
      
      if(@league)
        @league.position = team.at_xpath('position').content
        @league.played = team.at_xpath('played').content
        @league.win = team.at_xpath('won').content
        @league.drawn = team.at_xpath('drawn').content
        @league.lost = team.at_xpath('lost').content
        @league.for = team.at_xpath('for').content
        @league.against = team.at_xpath('against').content
        @league.goal_difference = team.at_xpath('goalDifference').content
        @league.points = team.at_xpath('points').content
        @league.save
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
      params.require(:bet).permit(:user_id, :league_id, :position)
    end
    
    def is_long_time_since_update
      now = DateTime.now
      latest_update = League.first.updated_at
      distance_in_hour = ((now.to_i - latest_update.to_i).abs) / 3600
      distance_in_hour > 1
    end
end
