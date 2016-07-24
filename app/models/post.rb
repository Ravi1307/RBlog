class Post < ActiveRecord::Base
  
  belongs_to :account;
  has_many :comments, :dependent => :destroy;
  
  validates :post_title, :presence => true, :length => {:maximum => 200};
  validates :post_message, :presence => true;
  validates :account_id, :presence => true;
  
  scope :rBlogUserPosts, lambda { |account_id| Account.find(account_id).posts }
  scope :rUserPostsCount, lambda { |username| ((username == nil) ? Post.count : Account.find_by_username(username).posts.count) }
  scope :rRecentPosts, lambda { |username, lim, from| ((username == nil) ? Post.order(:updated_at => :desc).offset(from).limit(lim) : Account.find_by_username(username).posts.order(:updated_at => :desc).offset(from).limit(lim)) }

end
