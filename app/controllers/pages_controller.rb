class PagesController < ApplicationController

  verify :params => :id, :only => :show, :redirect_to => :login_url
  before_filter :ensure_valid, :only => :show

  def show
    render :template => "pages/#{page}", :layout => !request.xhr?
  end

  protected
  
  def page
    params[:id].to_s.downcase
  end
  
  def ensure_valid
    unless %w(home).include? page
      render :nothing => true, :status => 404 and return false
    end
  end

end