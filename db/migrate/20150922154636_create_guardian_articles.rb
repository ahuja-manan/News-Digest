class CreateGuardianArticles < ActiveRecord::Migration
  def change
    create_table :guardian_articles do |t|
      t.string :title
      t.string :pub_date
      t.string :summary
      t.string :author
      t.string :img
      t.string :link
      t.string :category_name

      t.timestamps null: false
    end
  end
end
