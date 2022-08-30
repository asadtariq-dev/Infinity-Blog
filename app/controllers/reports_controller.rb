class ReportsController < ApplicationController
  def create
    @report = current_author.reports.new(report_params)

    Post.find(report_params[:post_id]).update_attribute(:reported, true)

    flash[:notice] = @report.errors.full_messages.to_sentence unless @report.save

    redirect_to @report.post if @report.comment.nil?
    redirect_to @report.comment if @report.post.nil?
  end

  def destroy
    @report = current_author.reports.find(params[:id])

    @report.destroy
    Post.find(report_params[:post_id]).update_attribute(:reported, false) if Post.joins(:reports).nil?
    redirect_to @report.post if @report.comment.nil?
    redirect_to @report.comment if @report.post.nil?
  end

  private

  def report_params
    params.require(:report).permit(:post_id, :comment_id)
  end
end
