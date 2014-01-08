json.array!(@cpanel_permissions) do |cpanel_permission|
  json.extract! cpanel_permission, :action, :subject, :description
  json.url cpanel_permission_url(cpanel_permission, format: :json)
end
