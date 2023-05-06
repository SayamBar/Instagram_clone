class Api::V1::PostsController < Api::V1::ApplicationController
    def index
        @posts = Post.all
        render json:@posts, status: 200
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
end
