class Post < ActiveRecord::Base
  
  belongs_to :account;
  has_many :comments, :dependent => :destroy;
  
  validates :post_title, :presence => true, :length => {:maximum => 200};
  validates :post_message, :presence => true;
  validates :account_id, :presence => true;
  
  scope :rBlogUserPosts, lambda { |account_id| Account.find(account_id).posts }
  scope :rUserPostsCount, lambda { |username| ((username == nil) ? Post.count : Post.includes(:account).where('accounts.username' => username).count) }
  scope :rRecentPosts, lambda { |username, lim, from| ((username == nil) ? Post.includes(:account).order(:updated_at => :desc).offset(from).limit(lim) : Post.includes(:account).where('accounts.username' => username).order(:updated_at => :desc).limit(lim).offset(from)) }

end
