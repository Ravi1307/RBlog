class Post < ActiveRecord::Base
  
  belongs_to :account; 
  
  validates :post_title, :presence => true, :uniqueness => true, :length => {:maximum => 200};
  validates :post_message, :presence => true;
  validates :account_id, :presence => true;
  
  scope :rBlogSitemap, lambda { Account.includes(:posts) }
  scope :rPostTitle, lambda { |id| Post.find(id).post_title }
  scope :rPostsTitle, lambda { |account_id| where(:account_id => account_id) }
  scope :rUserPostsCount, lambda { |username| ((username == nil) ? Post.count : Post.includes(:account).where('accounts.username' => username).count) }
  scope :rRecentPosts, lambda { |username, lim, from| ((username == nil) ? Post.includes(:account).order(:updated_at => :desc).offset(from).limit(lim) : Post.includes(:account).where('accounts.username' => username).order(:updated_at => :desc).limit(lim).offset(from)) }
  
end
