class ChangeUsersColumnFormat < ActiveRecord::Migration
  def change
  	change_column :users, :is_registered, :integer
  end
end
