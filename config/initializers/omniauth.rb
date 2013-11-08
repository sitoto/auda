OmniAuth.config.on_failure do |env|
    [302, {'Location' => "/auth/#{env['omniauth.error.strategy'].name}/failure?message=#{env['omniauth.error.type']}"}, ["Redirecting..."]]
end
Rails.application.config.middleware.use OmniAuth::Builder do
  # ...
  provider :identity, fields: [:name, :email], on_failed_registration: lambda { |env|
    IdentitiesController.action(:new).call(env)
  }
end

