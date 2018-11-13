class PagesController < ApplicationController
    def home
        if logged_in? 
            redirect_to articles_url
        end 
        
    end
    def about
        
    end
end
