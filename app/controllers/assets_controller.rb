class AssetsController < ApplicationController
  
  before_filter :login_required
  before_filter :load_project
  
  def new
    @asset = @project.assets.build
  end
  
  def create
    @asset = @project.assets.build(params[:asset])
    
    if @asset.save
      head :ok
    else
      head :error
    end
  end
  
  
  private
  def load_project
    @project = current_user.projects.find(params[:project_id])
  end
  
end
