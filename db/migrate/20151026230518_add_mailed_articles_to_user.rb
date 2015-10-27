class AddMailedArticlesToUser < ActiveRecord::Migration
  def change
    add_column :users, :mailed_articles, :text
  end
end
