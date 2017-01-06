class CreateCollaborators < ActiveRecord::Migration[5.0]
  def change
    create_table :collaborators do |t|
      t.string :email
      t.integer :wiki_id


      t.timestamps
    end

    add_index :collaborators, :wiki_id
    
  end
end
