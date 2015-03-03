class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  # GET '/'
  def index

  end

  def set_locale
    I18n.locale = "zh-CN"
  end

  def default_url_options options = {}
    options
  end
end
