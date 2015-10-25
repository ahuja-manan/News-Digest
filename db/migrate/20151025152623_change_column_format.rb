class ChangeColumnFormat < ActiveRecord::Migration
  def change
  	change_column :articles, :pub_date, :datetime
  end
end
