module ApplicationHelper
  def render_user_name_tag(user)
    if user.role.blank?
      user.name
    else
      "#{user.role}:#{user.name}" 
    end
  end
end
