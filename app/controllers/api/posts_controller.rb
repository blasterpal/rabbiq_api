class Api::PostsController < ApplicationController
  before_action :set_api_post, only: [:show, :update, :destroy]

  # GET /api/posts
  # GET /api/posts.json
  def index
    
    api_posts = Api::Post.all
    
    # Rabbit Sync - push 10k messages
    Publisher.publish("posts_all",api_posts)
    @api_posts = Subscriber.pop("posts_all")

    # Regular
    render json: @api_posts

  end

  # GET /api/posts/1
  # GET /api/posts/1.json
  def show
    render json: @api_post
  end

  # POST /api/posts
  # POST /api/posts.json
  def create
    @api_post = Api::Post.new(api_post_params)

    if @api_post.save
      render json: @api_post, status: :created, location: @api_post
    else
      render json: @api_post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/posts/1
  # PATCH/PUT /api/posts/1.json
  def update
    @api_post = Api::Post.find(params[:id])

    if @api_post.update(api_post_params)
      head :no_content
    else
      render json: @api_post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/posts/1
  # DELETE /api/posts/1.json
  def destroy
    @api_post.destroy

    head :no_content
  end

  private

    def set_api_post
      @api_post = Api::Post.find(params[:id])
    end

    def api_post_params
      params.require(:api_post).permit(:title, :body, :published)
    end
end
