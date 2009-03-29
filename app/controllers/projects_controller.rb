class ProjectsController < ApplicationController

  before_filter :load_user
  before_filter :login_required, :except => [:index, :show, :tag]

  # GET /projects
  def index
    @projects = @user.projects.paginate(:page => @page, :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.js do
        render :update do |page|
          page.insert_html :bottom, 'projects', :partial => @projects
        end
      end
    end
  end

  # GET /projects/1
  def show
    @project = Project.with(:assets).find(params[:id])
    @user ||= @project.user

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /projects/new
  def new
    @project = current_user.projects.build

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /projects/1/edit
  def edit
    @project = current_user.projects.find(params[:id])
  end

  # POST /projects
  def create
    @project = current_user.projects.build(params[:project])

    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to(user_projects_url(current_user)) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /projects/1
  def update
    @project = current_user.projects.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(user_projects_url(current_user)) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /projects/1
  def destroy
    @project = current_user.projects.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(user_projects_url(current_user)) }
    end
  end

  def tag
    @projects = @user.projects.find_tagged_with(params[:tag]).paginate(:page => @page, :per_page => 10)
    respond_to do |format|
      format.html
      format.js do
        render :update do |page|
          page.insert_html :bottom, 'projects', :partial => @projects
        end
      end
    end
  end

  private
  def load_user
    @user = User.find_by_login(params[:user_id])
  end

end
