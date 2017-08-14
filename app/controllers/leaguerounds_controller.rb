class LeagueroundsController < ApplicationController
  before_action :set_leagueround, only: [:show, :edit, :update, :destroy]

  # GET /leaguerounds
  # GET /leaguerounds.json
  def index
    season = 2017
    if(params[:season])
      season = params[:season]
    end
    @leaguerounds = Leagueround.where('seasonstartyear = ? AND position < ?',  season, 7).order(played: :desc).order(:position)
    @leaguerounds.each do |round|
      @users = User.all
      userpoints_round = {}
      for user in @users do
        user.hasBets = false
        user.points = 0
        for bet in user.bets do
          if (bet.seasonstartyear == season)
            user.hasBets = true
            if (bet.position == round.position && bet.league.name == round.name)
              userpoints_round[user.name] = 1
            else
              userpoints_round[user.name] = 0
            end
          end
        end
      end
      round.userpoints = userpoints_round
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
