# Pages controller
class PagesController < ApplicationController
  def home
    redirect_to articles_url if logged_in?
  end

  def about; end
end
