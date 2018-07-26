json.array!(@leaguerounds) do |leagueround|
  json.extract! leagueround, :id
  json.url leagueround_url(leagueround, format: :json)
end
