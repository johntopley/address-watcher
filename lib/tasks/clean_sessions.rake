namespace :db do
  namespace :sessions do
    desc 'Deletes old sessions from the sessions table.'
    task :clean => :environment do
      ActiveRecord::Base.connection.delete('DELETE from sessions WHERE updated_at < now() - 2 * 3600')
    end
  end
end