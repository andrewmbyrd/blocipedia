class AddUserToCollaboratedWikis < ActiveRecord::Migration[5.0]
  def change
    add_column :collaborated_wikis, :user_id, :integer
    add_index :collaborated_wikis, :user_id
  end
end
