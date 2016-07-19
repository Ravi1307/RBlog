class CreateAccounts < ActiveRecord::Migration
  
  def up
    
    create_table :accounts do |t|
      
      t.string :username, :null => false, :limit => 15;
      t.string :email_address, :null => false, :limit => 100;
      t.string :password, :null => false, :limit => 30;
      t.string :first_name, :limit => 25;
      t.string :last_name, :limit => 25;
      t.string :mobile_number, :limit => 10;
      t.timestamps :null => false;
      
    end
    
    add_index(:accounts, :email_address);
    add_index(:accounts, :username);
    
  end
  
  def down
    
    drop_table :accounts;
    
  end
  
end
