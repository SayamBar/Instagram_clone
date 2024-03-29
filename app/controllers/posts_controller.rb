class PostsController < UsersController
  # before_action :authenticate_user!
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authorize, only: %i[update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # GET /posts or /posts.json
  # rescue_from ActionController::RoutingError, with: :handle_routing_error

  # def handle_routing_error
  #  # Custom logic for handling routing errors
  #  render plain: 'Route not found', status: :not_found
  # end

  def index
    @posts = Post.all

      # @page = (params[:page] || 1).to_i
      # @per = (params[:per] || 1).to_i
      # @posts = Post.offset(@per * (@page - 1)).limit(@per)
    
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    # debugger
    @post = current_user.posts.create(post_params)
    
    if @post.valid?
        redirect_to post_path(@post)
    else
        flash[:errors] = @post.errors.full_messages
        redirect_to new_post_path(@post)
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    # debugger
    if @authorize
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to post_url(@post), notice: "You can't update this post"}
        format.json { render json: @post.errors, status: 401}
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    if @authorize
      @post.destroy

      respond_to do |format|
        format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html {redirect_to post_path(@post), notice: "You can't delete this post"}
        format.json { render json: @post.errors, status: 401}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:caption, :image)
    end

    def record_not_found
      # Custom logic for handling a record not found error
      render plain: 'Record not found', status: :not_found
    end

    def authorize
      # debugger
      @authorize = (current_user.id == @post.user_id)
    end

end
