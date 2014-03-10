require 'nokogiri'
require 'open-uri'
class BetsController < ApplicationController
  before_action :set_bet, only: [:show, :edit, :update, :destroy]

  # GET /bets
  # GET /bets.json
  def index
    update_teams
    @users = User.all
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
    end
  end
  
  def update_teams
    doc = Nokogiri::XML(open('http://www.footballwebpages.co.uk/league.xml?comp=1'))
    doc.xpath('//team').each do |team|
      name = team.at_xpath('name').content
      position = team.at_xpath('position').content
      @league = League.find_by_name(name)
      if(@league)
        @league.position = position
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
end
