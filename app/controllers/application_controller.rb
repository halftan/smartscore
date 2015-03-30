class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  @@redis = nil

  # GET '/'
  def index

  end

  def set_locale
    I18n.locale = "zh-CN"
  end

  def default_url_options options = {}
    options
  end

  def redis
    if @@redis.nil?
      @@redis = Redis.new host: Rails.configuration.x.redis_host, port: Rails.configuration.x.redis_port, driver: :hiredis
    end
    @@redis
  end
end
