class DropOld < ActiveRecord::Migration
  def change
  	drop_table :abc_articles
  	drop_table :age_articles
  	drop_table :guardian_articles
  	drop_table :herald_articles
  	drop_table :sbs_articles
  	drop_table :smh_articles
  	drop_table :ny_articles
  end
end
