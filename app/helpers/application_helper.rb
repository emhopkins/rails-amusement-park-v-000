module ApplicationHelper
	def current_user
		User.find(session[:user_id]) if session[:user_id].present?
	end
end
