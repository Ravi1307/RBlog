class CreatePosts < ActiveRecord::Migration

  def up
    
    create_table :posts do |t|
      
      t.references :account;
      t.string :post_title, :null => false, :limit => 200;
      t.text :post_message, :null => false;
      t.timestamps :null => false;
      
    end
    
    add_index(:posts, :account_id);
    
  end
  
  def down
    
    drop_table :posts;
    
  end
  
end
