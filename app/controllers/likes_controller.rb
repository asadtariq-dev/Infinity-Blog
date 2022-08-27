class LikesController < ApplicationController
  def create
    @like = current_author.likes.new(like_params)

    flash[:notice] = @like.errors.full_messages.to_sentence unless @like.save
    redirect_to @like.post
  end

  def destroy
    @like = current_author.likes.find(params[:id])
    post = @like.post

    @like.destroy
    redirect_to post
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end
end
