class Api::V1::PostsController < Api::V1::ApplicationController
    before_action :find_user, only: %i[create update destroy postsofcurrentuser createcomment]
    before_action :find_post, only: %i[show update destroy likescount showcomments createcomment]
    before_action :check_user, only: %i[update destroy]
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    def index
        if params[:caption_starts_with]
            # debugger
            @posts = Post.where("caption LIKE ?", "#{params[:caption_starts_with]}%")
            render json:@posts, status: 200
        else
            @posts = Post.all
            render json:@posts, status: 200
        end
    end
    def show
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
            render json:{error: "post not found" }, status: 404
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
        # debugger
        if @post.nil?
            render json:{ error: "No records found" }, status: 404
        else
            if @f
                @post.update(caption:params[:caption], user_id:@user.id)
                render json: @post, status: 200
            else
                render json:{error: "You can't update this post." }, status: 403
            end
        end
    end
    def destroy
        # debugger
        if @post.nil?
            render json:{error: "Post Not Found "}, status: 404
        else
            if @f
                @post.destroy
                render json: Post.all, status: 200
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
        render json: { error: "Post Not Found "}, status: 404 if @post.nil?
        render json: @post.likes.count, status: 200
    end

    def showcomments
        render json: { error: "Post Not Found "}, status: 404 if @post.nil?
        render json: @post.comments, status: 200
    end

    def createcomment
        # debugger
        render json: { error: "Post Not Found "}, status: 404 if @post.nil?
        @post.comments.create(comment: params[:comment], user_id: @user.id)
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
        def find_post
            @post = Post.find(params[:id])
        end
        def check_user
            @f = (@post.user.id == @user.id)
        end

end
