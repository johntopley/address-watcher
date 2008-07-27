default_run_options[:pty] = true
set :application, 'addresswatcher'
set :domain,      '209.20.82.43'
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