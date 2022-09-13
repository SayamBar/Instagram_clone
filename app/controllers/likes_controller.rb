class LikesController < ApplicationController
    before_action :find 
    def create
        if(params[:post_id])
            if already_post_liked?
                flash[:notice] = "You can't like more than once"
            else
                @post.likes.create(user_id: current_user.id)
            end
            redirect_to post_path(@post)
        else
            if already_comment_liked?
                flash[:notice] = "You can't like more than once"
            else
                @comment.likes.create(user_id: current_user.id)
            end
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
        def already_post_liked?
            Like.where(user_id: current_user.id,likeable_type: "Post").exists?
        end 
        def already_comment_liked?
            Like.where(user_id: current_user.id,likeable_type: "Comment").exists?
        end     
end


  