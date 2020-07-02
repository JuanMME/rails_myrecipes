class SessionsController < ApplicationController
    def new

    end

    def create
        user_email = params[:session][:email].downcase
        user_password = params[:session][:password]

        chef = Chef.find_by(email: user_email)

        if chef && chef.authenticate(user_password)
            # Stores it as a cookie in the browser
            session[:chef_id] = chef.id
            flash[:success] = "You have been successfully logged in"
            redirect_to chef
        else
            flash.now[:danger] = "Wrong email or password"
            render 'new'
        end
    end

    def destroy
        session[:chef_id] = nil
        flash[:success] = "You have logged out"
        redirect_to root_path
    end
end
