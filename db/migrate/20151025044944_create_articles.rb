class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :pub_date
      t.string :summary
      t.string :author
      t.string :img
      t.string :link
      t.integer :sourceID

      t.timestamps null: false
    end
  end
end
