class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def index
    @posts = Post.all
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post was created."
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = "Post has not been created."
      render "static_pages/home"
      # render 'users/show'
      # render {:action => "show", :controller => "users"}
      # render :controller => :users, :action => :show
      # render "/controller/action"
      # render :template => "users/show"
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post was deleted."
    redirect_to request.referrer || root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
