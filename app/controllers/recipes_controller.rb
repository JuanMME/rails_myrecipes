class RecipesController < ApplicationController
    def index
        @recipes = Recipe.all
    end

    def show
        set_recipe
    end

    def new
        @recipe = Recipe.new
    end

    def create
        @recipe = Recipe.new(recipe_params)
        # Temporarily
        @recipe.chef = Chef.first
        if @recipe.save
            flash[:success] = "Recipe was created successfully"
            redirect_to recipe_path(@recipe)
        else
            render 'new'
        end
    end

    def edit
        set_recipe
    end

    def update
        set_recipe
        if @recipe.update(recipe_params)
            flash[:success] = "Recipe was updated successfully"
            redirect_to recipe_path(@recipe)
        else
            render 'edit'
        end
    end

    private
    def set_recipe
        @recipe = Recipe.find(params[:id])
    end
    def recipe_params
        params.require(:recipe).permit(:name, :description)
    end
end
