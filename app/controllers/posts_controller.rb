class PostsController < ApplicationController

  before_filter :load_user
  before_filter :login_required, :except => [:index, :show]

  # GET /posts
  # GET /posts.xml
  def index
    @posts = @user.posts.paginate(:page => @page, :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.js do
        render :update do |page|
          page.insert_html :bottom, 'posts', :partial => @posts
        end
      end
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = @user.posts.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = current_user.posts.build

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /posts/1/edit
  def edit
    @post = current_user.posts.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = current_user.posts.build(params[:post])

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to(@post) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = current_user.posts.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to(@post) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(user_posts_path(current_user)) }
    end
  end

  private
  def load_user
    @user = User.find_by_login(params[:user_id])
  end

end
