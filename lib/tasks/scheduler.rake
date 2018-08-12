desc "This task is called by the Heroku scheduler add-on"

task :update_round => :environment do
  puts "Updating positions..."
  Leagueround.update_rounds

  puts "done."
end
