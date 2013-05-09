class CommentsController < ApplicationController
  
  before_filter :redirect_unless_signed_in
  
  def create
  	@post = Post.find(params[:post_id])
  	@comment = @post.comments.build text: params[:comment][:text],
                                    user_id: current_user.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post }
        format.json { render json: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  	@post = Post.find(params[:post_id])
  	@comment = @post.comments.find(params[:id])
  	@comment.destroy if @comment
  	
    respond_to do |format|
      format.html { redirect_to @post }
      format.json { head :no_content }
    end
  end
end