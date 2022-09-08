# frozen_string_literal: true

class ReportsController < ApplicationController
  def create
    @report = current_author.reports.new(report_params)

    if @report.save
      redirect_to @report.post, notice: 'Report Submitted' if @report.comment.nil?
      redirect_to @report.comment, notice: 'Report Submitted' if @report.post.nil?
    else
      flash[:notice] = @report.errors.full_messages.to_sentence
      redirect_to @report.post, alert: @report.errors.full_messages.to_sentence if @report.comment.nil?
      redirect_to @report.comment, alert: @report.errors.full_messages.to_sentence if @report.post.nil?
    end
  end

  def destroy
    @report = current_author.reports.find(params[:id])

    if @report.destroy
      redirect_to @report.post, alert: 'Report Cancelled' if @report.comment.nil?
      redirect_to @report.comment, alert: 'Report Cancelled' if @report.post.nil?
    else
      flash[:notice] = @report.errors.full_messages.to_sentence
      redirect_to @report.post, alert: @report.errors.full_messages.to_sentence if @report.comment.nil?
      redirect_to @report.comment, alert: @report.errors.full_messages.to_sentence if @report.post.nil?
    end
  end

  private

  def report_params
    params.require(:report).permit(:post_id, :comment_id)
  end
end
