load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

namespace :deploy do
  desc <<-DESC
    Creates symbolic links to configuration files after deployment.
  DESC
  task :link_config_files, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/config.yml #{release_path}/config/config.yml"
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
end