namespace :db do
  desc 'Drop, create, migrate then seed the database.'
  task :reset => :environment do
    #Rake::Task['db:drop'].invoke
    #Rake::Task['db:create'].invoke
    #Rake::Task['db:migrate'].invoke
    Rake::Task['db:migrate:reset'].invoke # It is assumed that this command performs the same as the commented code.
    Rake::Task['db:seed'].invoke
  end
end