class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # this around file will set the rails application to the current
  # users timezone if they are logged in, otherwise it is the default
  around_filter :user_time_zone, if: :current_user

  # cancan authorization error trapping so they see a nice message
  # and get redirected to the home page
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  private

  # for each request, we want to be sure the application time zone is
  # set according to their preferences, and be sure our time parser
  # chronic is also set to the same zone.
  def user_time_zone(&block)
    Time.use_zone(current_user.try(:time_zone), &block)
    Chronic.time_class = Time.zone
  end
end
