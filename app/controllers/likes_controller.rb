class LikesController < ApplicationController
    before_action :find 
    def create
        if(params[:post_id])
            @post.likes.create(user_id: current_user.id)
            redirect_to post_path(@post)
        else
            @comment.likes.create(user_id: current_user.id)
            post = Post.find(@comment.post_id)
            redirect_to post_path(post)
        end
    end
    def destroy
        if(params[:post_id])
            l = Like.where(user_id: current_user.id,likeable_type: "Post",likeable_id: @post.id)
            # debugger
            Like.destroy(l.ids)
            redirect_to post_path(@post)
        else
            l = Like.where(user_id: current_user.id,likeable_type: "Comment",likeable_id: @comment.id)
            Like.destroy(l.ids)
            post = Post.find(@comment.post_id)
            redirect_to post_path(post)
        end
        
    end
    
    private  
        def find
            if(params[:post_id])
                @post = Post.find(params[:post_id])
            else
                @comment = Comment.find(params[:comment_id])
            end
        end   
end


  