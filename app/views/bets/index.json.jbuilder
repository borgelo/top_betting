json.array!(@bets) do |bet|
  json.extract! bet, :id, :user_id, :league_id, :position
  json.url bet_url(bet, format: :json)
end
