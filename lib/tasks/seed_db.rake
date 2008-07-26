namespace :db do
  desc "Load seed fixtures (from db/seeddata) into the current environment's database." 
  task :seed => :environment do
    require 'yaml'
    config = YAML::load(open("#{RAILS_ROOT}/config/database.yml"))["#{RAILS_ENV}"]
    Dir.glob(RAILS_ROOT + '/db/seeddata/*.sql').each do |file|
      cmd = "mysql -u #{config['username']} -p#{config['password']} -h #{config['host']} #{config['database']} < #{file}"
      `#{cmd}`
    end
  end
end