# Load application configuration. See http://railscasts.com/episodes/85
APP_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/config.yml")[RAILS_ENV]