class AssetsController < ApplicationController
  
  before_filter :login_required
  before_filter :load_project
  
  def create
    @asset = @project.assets.build(params[:asset])
    
    respond_to do |format|
      if @asset.save
        format.html do 
          flash[:success] = "Photo uploaded successfully"
          redirect_to @project
        end
      else
        format.html do
          flash[:error] = "Photo not uploaded"
          redirect_to @project
        end
      end
    end
  end
  
  
  
  
  private
  def load_project
    @project = current_user.projects.find(params[:project_id])
  end
  
end
