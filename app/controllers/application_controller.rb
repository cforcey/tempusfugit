class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # this around file will set the rails application to the current
  # users timezone if they are logged in, otherwise it is the default
  around_filter :user_time_zone, if: :current_user

  private

  # for each request, we want to be sure the application time zone is
  # set according to their preferences, and be sure our time parser
  # chronic is also set to the same zone.
  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
    Chronic.time_class = Time.zone
  end
end
