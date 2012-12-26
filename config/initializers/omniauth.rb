if Rails.env.development?
  ENV["FACEBOOK_APP_ID"] = "401017706644512"
  ENV["FACEBOOK_SECRET"] = "3d8f8632bc02c3ae41822fcce93a8b3a"
end

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET']
end