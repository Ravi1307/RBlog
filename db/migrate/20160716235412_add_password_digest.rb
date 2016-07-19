class AddPasswordDigest < ActiveRecord::Migration
  
  def up
    
    remove_column :accounts, :password;
    add_column :accounts, :password_digest, :string, :null => false;
    
  end
  
  def down
    
    remove_column :accounts, :password_digest;
    add_column :accounts, :password, :string, :null => false, :limit => 30;
    
  end
  
end
