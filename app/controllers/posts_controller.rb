class PostsController < ApplicationController
  before_action :load_post, except: %i{index new create}

  def index
    @posts = Post.page(params[:page])
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    ok, @post = PostService::Create.call(post_params)

    respond_to do |format|
      if ok
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    ok, = PostService::Update.call(@post, post_params)

    respond_to do |format|
      if ok
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    PostService::Destroy.call(@post)

    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def load_post
    @post = Post.find(params.expect(:id))
  end

  def post_params
    params.expect(post: [:body, :scheduled_at, :draft, attachments: []])
  end
end
