default_run_options[:pty] = true
set :application, 'addresswatcher'
set :domain,      'addresswatcher.com'
set :user,        'deploy'
set :repository,  'git@github.com:johntopley/address-watcher.git'
set :scm,         'git'
set :branch,      'master'
set :port,        30000

set :deploy_to, "/home/deploy/public_html/#{application}"
set :deploy_via, :copy

role :app, domain
role :web, domain
role :db,  domain, :primary => true

set :runner, user
set :mongrel_conf, "#{shared_path}/config/mongrel_cluster.yml"

after :deploy, 'deploy:link_config_files'

namespace :deploy do
  desc <<-DESC
    Creates symbolic links to configuration files after deployment.
  DESC
  task :link_config_files, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/config.yml #{release_path}/config/config.yml"
    run "ln -nfs #{shared_path}/config/newrelic.yml #{release_path}/config/newrelic.yml"
  end
  
  namespace :mongrel do
    [:stop, :start, :restart].each do |t|
      desc "#{t.to_s.capitalize}s the Mongrel application server."
      task t, :roles => :app do
        invoke_command "mongrel_rails cluster::#{t.to_s} -C #{mongrel_conf}",
          :via => run_method
      end
    end
  end
  
  desc 'Custom restart task for Mongrel cluster.'
  task :restart, :roles => :app, :except => { :no_release => true } do
    deploy.mongrel.restart
  end
  
  desc 'Custom start task for Mongrel cluster.'
  task :start, :roles => :app do
    deploy.mongrel.start
  end
  
  desc 'Custom stop task for Mongrel cluster.'
  task :stop, :roles => :app do
    deploy.mongrel.stop
  end
  
  namespace :web do
    desc <<-DESC
      Present a maintenance page to visitors. Disables your application's web \
      interface by writing a "maintenance.html" file to each web server. The \
      servers must be configured to detect the presence of this file, and if \
      it is present, always display it instead of performing the request.

      By default, the maintenance page will just say the site is down for \
      "maintenance", and will be back "shortly", but you can customize the \
      page by specifying the REASON and UNTIL environment variables:

        $ cap deploy:web:disable \\
              REASON="a hardware upgrade" \\
              UNTIL="12pm Central Time"

      Further customization will require that you write your own task.
    DESC
    task :disable, :roles => :web do
      require 'erb'
      on_rollback { run "rm #{shared_path}/system/maintenance.html" }
      
      reason = ENV['REASON']
      deadline = ENV['UNTIL']      
      template = File.read('app/views/admin/maintenance.html.erb')
      page = ERB.new(template).result(binding)
      
      put page, "#{shared_path}/system/maintenance.html", :mode => 0644
    end
  end
end