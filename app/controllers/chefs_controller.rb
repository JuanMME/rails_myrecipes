class ChefsController < ApplicationController
    before_action :set_chef, only: [:show]
    def show

    end

    def new
        @chef = Chef.new
    end

    def create
        @chef = Chef.new(chef_params)
        if @chef.save
            flash[:success] = "Welcome #{@chef.chefname} to MyRecipes app!"
            redirect_to chef_path(@chef)
        else
            render 'new'
        end
    end

    private
    def set_chef
        @chef = Chef.find(params[:id])
    end
    def chef_params
        params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
    end
end
