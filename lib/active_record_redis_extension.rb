module ActiveRecordRedisExtension

  extend ActiveSupport::Concern

  @@redis = nil

  def redis
    if @@redis.nil?
      @@redis = Redis.new host: Rails.configuration.x.redis_host, port: Rails.configuration.x.redis_port, driver: :hiredis
    end
    @@redis
  end
end

ActiveRecord::Base.send :include, ActiveRecordRedisExtension
