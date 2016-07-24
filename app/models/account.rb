class Account < ActiveRecord::Base
  
  has_secure_password;
  
  has_many :posts, :dependent => :destroy;
  
  validates :first_name, :presence => true, :length => {:maximum => 25}, :on => :update;
  validates :last_name, :presence => true, :length => {:maximum => 25}, :on => :update;
  validates :username, :presence => true, :uniqueness => true, :length => {:in => 4...15};
  validates :email_address, :presence => true, :uniqueness => true, :length => {:maximum => 100};
  validates :mobile_number, :presence => true, :length => {:is => 10}, :format => /\d{10}/, :on => :update;
  validates :password, :presence => true, :length => {:in => 6...30}, :on => :create;
  validates :password, :presence => true, :length => {:in => 6...30}, :on => :changePassword;
  validates :password_confirmation, :presence => true, :on => :create;
  validates :password_confirmation, :presence => true, :on => :changePassword;
  
end
