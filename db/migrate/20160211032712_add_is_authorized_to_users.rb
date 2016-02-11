class AddIsAuthorizedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_authorized, :boolean, :default => false
  end
end
