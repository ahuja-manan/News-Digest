#
# This controller imports and scrapes data from 6 different
# sources. It then puts all this interpreted & validated data i
# into an array for rendering to the index view.
#

class ImporterController < ApplicationController
before_action :authenticate_user

  def index
  	@articles = Article.all.paginate(:page => params[:page], :per_page => 10)

    # If there is a search term entered, search through the articles, which
    # will be returned
    if params[:search]
      @articles = Article.search(params[:search], @articles)

    # If no search term entered, rank articles in descending order
    else
      @articles.order! 'pub_date DESC'
    end
  end

  def my_interests
    @articles = Article.tagged_with(current_user.interest_list, :any => true).paginate(:page => params[:page], :per_page => 10).to_a
    render 'index'
  end
end
