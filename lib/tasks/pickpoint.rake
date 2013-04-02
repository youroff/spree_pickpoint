namespace :pickpoint do
  desc %q{Sync (update) pick points}
  task :sync => :environment do
    Spree::Pickpoint.sync!
  end
end