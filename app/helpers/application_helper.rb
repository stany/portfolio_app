# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def owner_area(&block)
    if current_user && current_user == @user
      concat capture(&block)
    end
  end
  
end
