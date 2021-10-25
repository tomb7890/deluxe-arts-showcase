namespace :util do
  desc "Fix up stuff "
  task :setdefaultimage => :environment do
    g = Gleaner.new
    g.set_default_image
  end
end
