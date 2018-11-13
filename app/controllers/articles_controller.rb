class ArticlesController < ApplicationController

  before_action :find_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, except: [:index, :show, :new,:create] 

   def index
     @articles =Article.paginate(page: params[:page], per_page: 5)
    end
  def new
       @article = Article.new    
  end 
  
  def edit
    
  end
  
  def show
      
  end

  def create
    
    @article = Article.new(article_params)
    @article.user = current_user
    
    if @article.save
      flash[:success] = "Article was created !"  
      redirect_to article_path(@article)
     else
        render 'new'
    end
  end

  def update
    
    
    if @article.update(article_params)
      flash[:success] = "Article was updated !"
      redirect_to article_path(@article)
    else
      render 'edit'
      
    end
    
  end
  def destroy
    
    @article.destroy
    flash[:danger] = 'Artice was successfully deleted'
    redirect_to articles_url
  end
  private
  def article_params
    params.require(:article).permit(:title, :description)
  end
  def find_article
    @article = Article.find(params[:id])
  end
  def require_user
    if !logged_in?
      flash[:danger] = "Please login first"
      redirect_to login_url
    end
  end
  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:danger] = "You can only modify your own articles"
      redirect_to articles_url
    end
  end
end
