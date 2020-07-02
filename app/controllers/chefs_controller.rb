class ChefsController < ApplicationController
    before_action :set_chef, only: [:show, :edit, :update, :destroy]

    def index
        @chefs = Chef.paginate(page: params[:page], per_page: 5)
    end

    def show
        @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 5)
    end

    def new
        @chef = Chef.new
    end

    def create
        @chef = Chef.new(chef_params)
        if @chef.save
            session[:chef_id] = @chef.id
            flash[:success] = "Welcome #{@chef.chefname} to MyRecipes app!"
            redirect_to chef_path(@chef)
        else
            render 'new'
        end
    end

    def edit

    end

    def update
        if @chef.update(chef_params)
            flash[:success] = "Your account was updated successfully"
            redirect_to @chef
        else
            render 'edit'
        end
    end

    def destroy
        if @chef.destroy
            flash[:success] = "Chef deleted successfully"
            redirect_to chefs_path
        else
            flash.now[:danger] = "There was an error deleting the chef"
            render 'index'
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
