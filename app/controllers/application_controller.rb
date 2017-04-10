class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # https://github.com/presidentbeef/brakeman/blob/master/docs/warning_types/cross-site_request_forgery/index.markdown
  # protect_from_forgery with: :exception

  # https://github.com/presidentbeef/brakeman/blob/master/docs/warning_types/basic_auth/index.markdown
  http_basic_authenticate_with :name => "user", :password => "secret", :except => :index
end
