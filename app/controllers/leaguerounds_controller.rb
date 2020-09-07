class LeagueroundsController < ApplicationController
  before_action :set_leagueround, only: [:show, :edit, :update, :destroy]

  # GET /leaguerounds
  # GET /leaguerounds.json
  def index
    season = 2020
    @allrounds = Leagueround.all
    @rounds = Array.new
    @round_points = Array.new
    table = Array.new(6)

    if(params[:season])
      season = params[:season]
    end
    @leaguerounds = Leagueround.where('seasonstartyear = ? ',  season).
        order(played: :desc, points: :desc, goal_difference: :desc, for: :desc, )
    usersum_round = {}
    pos = 0
    lastPlayed = -1
    @leaguerounds.each do |team|
      if team.played != lastPlayed
        pos = 1
      end
      lastPlayed = team.played
      if pos < 7
        bets = Bet.where('seasonStartYear = ? AND position = ?', season, pos)
        userpoints_round = {}

        for bet in bets do
          if usersum_round[bet.user.name] == nil
            usersum_round[bet.user.name] = 0
          end
            if (bet.league.name == team.name)
              userpoints_round[bet.user.name] = 1
              usersum_round[bet.user.name] = usersum_round[bet.user.name] + 1
            else
              userpoints_round[bet.user.name] = 0
            end
            team.userpoints = userpoints_round
            table[pos - 1] = team
        end

        if pos == 6
          @round_points[team.played-1] = usersum_round
          @rounds[team.played-1] = table.dup
          usersum_round = {}
          table = Array.new(6)
        end
      end
      pos = pos + 1
    end
  end


  # GET /leaguerounds/1
  # GET /leaguerounds/1.json
  def show
  end

  # GET /leaguerounds/new
  def new
    @leagueround = Leagueround.new
  end

  # GET /leaguerounds/1/edit
  def edit
  end

  # POST /leaguerounds
  # POST /leaguerounds.json
  def create
    @leagueround = Leagueround.new(leagueround_params)

    respond_to do |format|
      if @leagueround.save
        format.html { redirect_to @leagueround, notice: 'Leagueround was successfully created.' }
        format.json { render action: 'show', status: :created, location: @leagueround }
      else
        format.html { render action: 'new' }
        format.json { render json: @leagueround.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leaguerounds/1
  # PATCH/PUT /leaguerounds/1.json
  def update
    respond_to do |format|
      if @leagueround.update(leagueround_params)
        format.html { redirect_to @leagueround, notice: 'Leagueround was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @leagueround.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leaguerounds/1
  # DELETE /leaguerounds/1.json
  def destroy
    @leagueround.destroy
    respond_to do |format|
      format.html { redirect_to leaguerounds_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leagueround
      @leagueround = Leagueround.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def leagueround_params
      params[:leagueround]
    end
end
