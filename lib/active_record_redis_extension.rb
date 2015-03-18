module ActiveRecordRedisExtension

  extend ActiveSupport::Concern

  @@redis = nil

  def redis
    if @@redis.nil?
      @@redis = Redis.new driver: :hiredis
    end
    @@redis
  end
end

ActiveRecord::Base.send :include, ActiveRecordRedisExtension
