class CreateSbsArticles < ActiveRecord::Migration
  def change
    create_table :sbs_articles do |t|
      t.string :title
      t.string :pub_date
      t.string :summary
      t.string :author
      t.string :img
      t.string :link

      t.timestamps null: false
    end
  end
end
