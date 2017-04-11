class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.

    # https://github.com/presidentbeef/brakeman/blob/master/docs/warning_types/cross-site_request_forgery/index.markdown
    # protect_from_forgery with: :exception

    private

        def logined
            if session[:id].nil? then
                redirect_to controller: 'sessions', action: 'index'
            end
        end

end
