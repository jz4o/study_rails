namespace :study_rails do
  desc 'example simple rake task'
  task :bundle_outdated do
    puts `bundle outdated --parseable`
  end

  desc 'example connect to database'
  task first_user: :environment do # require environment argument
    puts User.first.inspect
  end
end
