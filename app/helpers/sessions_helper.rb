module SessionsHelper
  
  # Logs in the user
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  # Get the Current User
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Check if user is logged in
  def logged_in?
    !current_user.nil?
  end
end
