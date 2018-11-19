# Articles Controller
class ArticlesController < ApplicationController
  before_action :find_article, only: %i[edit update show destroy]
  before_action :require_user, except: %i[index show]
  before_action :require_same_user, except: %i[index show new create]

  def index
    @articles = Article.order('updated_at DESC')
                       .paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit; end

  def show; end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      flash[:success] = 'Article was created !'
      redirect_to article_path(@article)
    else
      flash[:danger]='could not create the article'
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = 'Article was updated !'
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
    params.require(:article).permit(:title, :description, category_ids:[])
  end

  def find_article
    @article = Article.find(params[:id])
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:danger] = 'You can only modify your own articles'
      
    end
  end
end
