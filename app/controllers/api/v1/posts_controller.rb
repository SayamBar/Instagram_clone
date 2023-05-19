class Api::V1::PostsController < Api::V1::ApplicationController
    before_action :find_user, only: %i[create update destroy postsofcurrentuser]
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    def index
        if params[:caption_starts_with]
            # debugger
            @posts = Post.where("caption LIKE ?", "#{params[:caption_starts_with]}%")
            if @posts.empty?
                render json:{ error: "No records found" }, status: 404
            else
                render json:@posts, status: 200
            end
        else
            @posts = Post.all
            render json:@posts, status: 200
        end
    end
    def show
        @post = Post.find(params[:id])
        @res = {}
        @url = []
        if @post.image.attached?
            @url << rails_blob_url(@post.image)
        end
        if @post
            @res[:post] = [@post]
            @res[:post] << @url if !@url.empty?
            # debugger
            render json: @res, status: 200
        else
            render json:{error: "post not found" }
        end
    end
    def create 
        @post = Post.new(caption: params[:caption], user_id:@user.id)
        # debugger
        # @post.images.attach([params[:images]])
        if @post.save
            render json: @post, status: 201
        else
            render json: { error: "Post not created"}, status: :unprocessable_entity
        end
    end
    def update
        @post = Post.find_by(id: params[:id])
        # debugger
        if @post.nil?
            render json:{ error: "No records found" }, status: 404
        else
            if @post.user.id == @user.id
                @post.update(caption:params[:caption], user_id:@user.id)
                render json: @post
            else
                render json:{error: "You can't update this post." }, status: 403
            end
        end
    end
    def destroy
        @post = Post.find_by(id: params[:id])
        # debugger
        if @post.nil?
            render json:{}, status: 404
        else
            if @post.user.id == @user.id
                @post.destroy
                render json: Post.all
            else
                render json:{error: "You can't delete the post" }, status: 403
            end
        end
    end

    def postsofcurrentuser
        render json: @user.posts, status: 200
    end

    def likescount
        # debugger
        @post = Post.find(params[:post_id])
        render json: @post.likes.count, status: 200
    end

    def showcomments
        @post = Post.find(params[:post_id])
        render json: @post.comments, status: 200
    end

    private
        def find_user
            @bearer_token = request.headers['Authorization']&.split(' ')&.last
            @resource_owner = Doorkeeper::AccessToken.find_by(token:@bearer_token)
            @user = User.find(@resource_owner.resource_owner_id)
        end
        def record_not_found
            # Custom logic for handling a record not found error
            render plain: 'Record not found', status: :not_found
        end

end
