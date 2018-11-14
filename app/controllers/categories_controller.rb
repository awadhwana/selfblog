class CategoriesController < ApplicationController
    def index
        @categories = Category.all
        
    end

    def show
        @category = Category.find(params[:id])
    end

    def new
        @category = Category.new
    end

    def edit
        
    end

    def create
        
        @category = Category.new(category_params)
        if @category.save
            flash[:success]="Category successfuly created"
            redirect_to categories_url
        else
            flash[:danger]="Please try again"
            render :new
         
        end    

    end

    def update
        
    end

    def destroy
        
    end
    private
    def category_params
        params.require(:category).permit(:name)
    end
end
