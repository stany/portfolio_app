class ProjectsController < ApplicationController

  before_filter :check_user
  before_filter :login_required, :except => [:index, :show]

  # GET /projects
  def index
    @projects = @user.projects.all.paginate(:page => @page, :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /projects/1
  def show
    @project = @user.projects.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /projects/new
  def new
    @project = @user.projects.build

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /projects/1/edit
  def edit
    @project = @user.projects.find(params[:id])
  end

  # POST /projects
  def create
    @project = @user.projects.build(params[:project])

    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to(projects_url) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /projects/1
  def update
    @project = @user.projects.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(projects_url) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /projects/1
  def destroy
    @project = @user.projects.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
    end
  end

  private
  def check_user
    redirect_to root_url(:subdomain => false) and return unless @user
  end

end
