class CategoriesController < ApplicationController
    before_action :require_admin , except: %i[index show]
    def index
        @categories = Category.order("updated_at DESC").paginate(page: params[:page], per_page: 3)   
    end

    def show
        @category = Category.find(params[:id])
        @category_articles = @category.articles.paginate(page: params[:page], per_page: 1)
    end

    def new
        @category = Category.new
    end

    def edit
        @category = Category.find(params[:id])
        
    end

    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:success]="Category successfuly created"
            redirect_to categories_url
        else
            flash[:danger]="Something went wrong, please try again"
            render :new
         
        end

    end

    def update
        @category = Category.find(params[:id])
        if @category.update(category_params)
            flash[:success]='Category successfuly updated'
            redirect_to categories_url
        else
         flash[:danger] = 'Something went wrong, please try again'
            render :edit
        end
    end

    def destroy
        
    end
    private
    def category_params
        params.require(:category).permit(:name)
    end
    def require_admin
        if !require_user && !current_user.admin?
            flash[:danger] = 'Only admin can perform this action'
            redirect_to categories_url
        end
    end
end
