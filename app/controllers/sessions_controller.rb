class SessionsController < ApplicationController

    def index

    end

    def login
        # https://github.com/presidentbeef/brakeman/blob/master/docs/warning_types/sql_injection/index.markdown
        @user = User.where("login_id = '" + params[:session][:login_id].to_s + "' AND password = '" + params[:session][:password].to_s + "'").first
        
        if @user.nil? then
            flash[:alert] = 'Login failed.'
            redirect_to action: 'index'
        else
            session[:id] = @user.id
            redirect_to controller: 'books', action: 'index'
        end
    end

    def logout
        reset_session
        redirect_to action: 'index'
    end

end
