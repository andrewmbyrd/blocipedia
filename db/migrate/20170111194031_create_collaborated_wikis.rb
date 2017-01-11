class CreateCollaboratedWikis < ActiveRecord::Migration[5.0]
  def change
    create_table :collaborated_wikis do |t|
      t.integer :wiki_id
      t.integer :collaborator_id

      t.timestamps
    end
    add_index :collaborated_wikis, :wiki_id
    add_index :collaborated_wikis, :collaborator_id
    add_index :collaborated_wikis, [:wiki_id,:collaborator_id], unique: true
  end
end
