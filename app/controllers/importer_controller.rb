# This controller lets a User look at all articles, interested articles,
# and search all articles.
# One page only contains ten articles.
class ImporterController < ApplicationController
  before_action :authenticate_user

  def index
    @articles = Article.all

    # If there is a search term entered, search through the articles
    # an array of articles will be returned, sorted by weight and date
    if params[:search]
      @articles = Article.search(params[:search], @articles).paginate(page: params[:page], per_page: 10)

    # If no search term entered, sort articles by date
    else
      @articles = @articles.order(pub_date: :desc)
      @articles = @articles.to_a.paginate(page: params[:page], per_page: 10)
    end
  end

  # returns an array of articles that have the same tags as a user's interests
  def my_interests
    @articles = Article.tagged_with(current_user.interest_list, any: true).to_a.paginate(page: params[:page], per_page: 10)
    render 'index'
  end
end
