require "redis"
require "redis-namespace"
require "redis/objects"

redis_config = YAML.load_file("#{Rails.root}/config/redis.yml")[Rails.env]
redis_host = redis_config['host']
redis_port = redis_config['port']
redis_password = redis_config['password'].blank? ? nil : redis_config['password']

### Sidekiq
sidekiq_db_num = 0
namespace_sidekiq = 'sidekiq'
Sidekiq.configure_server do |config|
  config.redis = { :host => redis_host, :port => redis_port, :db => sidekiq_db_num, password: redis_password, :namespace => namespace_sidekiq }
end

Sidekiq.configure_client do |config|
  config.redis = { :host => redis_host, :port => redis_port, :db => sidekiq_db_num, password: redis_password, :namespace => namespace_sidekiq }
end