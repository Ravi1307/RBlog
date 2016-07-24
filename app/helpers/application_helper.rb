module ApplicationHelper
  

  def getUsername(userId)
    
    return Account.find(userId).username;
    
  end
  
  def getRBlogUsers
    
    return Account.all;
    
  end
  
end
