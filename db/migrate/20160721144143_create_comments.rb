class CreateComments < ActiveRecord::Migration
  
  def up
    
    create_table :comments do |t|

      t.references :post;
      t.references :account;
      t.text :comment_message, :null => false;
      t.timestamps :null => false;
      
    end

    add_index(:comments, :account_id);
    add_index(:comments, :post_id);
    
  end
  
  def down
    
    drop_table :comments;
    
  end
  
end
