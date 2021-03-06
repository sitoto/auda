module ApplicationHelper
 def render_user_name_tag(user)
    if user.role.blank?
      "#{t('users.name')}:#{user.name}"
    else
      "#{t('users.name')}:#{user.name}, #{t('users.role')}:#{user.role}" 
    end
  end

  def render_page_title
    title = @page_title ? "#{@page_title} #{t('site_name')}" : t('site_name') rescue 'error' 
    content_tag("title", title, nil, false)
  end

  def notice_message
    flash_messages = []
    flash.each do |type, message|
      type = :success if type == :notice
      text = content_tag(:div, link_to("x", "#", :class => "close", 'data-dismiss' => "alert") + message, :class => "alert alert-#{type}")
      flash_messages << text if message
    end

    flash_messages.join("\n").html_safe
  end

  def timeago(time, options = {})
    options[:class]
    options[:class] = options[:class].blank? ? "timeago" : [options[:class],"timeago"].join(" ")
    content_tag(:abbr, "", options.merge(:title => time.iso8601)) if time
  end 
end
