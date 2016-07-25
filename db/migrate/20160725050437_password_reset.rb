class PasswordReset < ActiveRecord::Migration
  
  def up
    
    add_column(:accounts, :password_reset_token, :string);
    
  end
  
  def down
    
    remove_column(:accounts, :password_reset_token);
    
  end
  
end
