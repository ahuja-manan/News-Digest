class RemoveColumn < ActiveRecord::Migration
  def change
  	remove_column :sources, :sourceID
  	remove_column :articles, :sourceID
  end
end
