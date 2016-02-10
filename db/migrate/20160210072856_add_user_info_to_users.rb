class AddUserInfoToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :foursquare_id, :string
  	add_column :users, :email, :string
  	add_column :users, :first_name, :string
  	add_column :users, :last_name, :string
  	add_column :users, :profile_url, :string
  	add_column :users, :avatar_url, :string
  end
end
