#
# This controller imports and scrapes data from 6 different
# sources. It then puts all this interpreted & validated data i
# into an array for rendering to the index view.
#

class ImporterController < ApplicationController
before_action :authenticate_user

  def index
  	@articles = Article.all

    # If there is a search term entered, search through the articles, which
    # will be returned
    if params[:search]
      @articles = Article.search(params[:search], @articles).paginate(:page => params[:page], :per_page => 10)

    # If no search term entered, rank articles in descending order
    else
      @articles = @articles.order(pub_date: :desc)
      @articles = @articles.to_a.paginate(:page => params[:page], :per_page => 10)
    end
  end

  def my_interests
    @articles = Article.tagged_with(current_user.interest_list, :any => true).to_a.paginate(:page => params[:page], :per_page => 10)
    render 'index'
  end
end
